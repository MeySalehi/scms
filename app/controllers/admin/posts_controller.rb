class Admin::PostsController < ApplicationController
  before_action :confirm_logged_in
  
  ERR404 = "#{Rails.root}/public/404.html"

  def index
    limit = 2 # set by options
    page = params[:page].to_i == 0 ? 1 : params[:page].to_i
    user = User.find_by(username: params[:username])
    if !user.blank?
      user_id = user.id
    else
      user_id = session[:user_id]
    end
    @posts = Post.user_posts(user_id, page, limit, "POST")

    post_count = Post.user_posts_count(user_id, "POST")

    if post_count < limit
      @page_num = 1
    elsif (post_count % limit) == 0
      @page_num = post_count / limit
    else
      @page_num = (post_count / limit) + 1
    end
    if page > @page_num
      return render file: ERR404
    end
    @user_id = user_id
    @username = params[:user_username]
    @current_page = page
  end
  #---------------------------------------------------
  def new
    @post = Post.new
  end
  #---------------------------------------------------  
  def create
    params = create_params
    new_post = Post.new(params)
    if new_post.save
      flash[:notice] = "'#{params[:title]}' Successfully created."
      return redirect_to admin_posts_path
    else
      flash[:erroe] = "Sorry, we have an internal error for create '#{params[:title]}'."
      return redirect_to new_admin_post_path
    end
  end
  #---------------------------------------------------
  def edit  
    @post = Post.find(params[:id].to_i)
  end

  def update
    # params = create_params
    post = Post.find(params[:id].to_i)
    
    if post.update(create_params)
      flash[:notice] = "'#{params[:title]}' Successfully edited."
      return redirect_to admin_posts_path
    else
      flash[:erroe] = "Sorry, we have an internal error for edit '#{params[:title]}'."
      return redirect_to new_admin_post_path
    end
  end

  def destroy
  end

  private
    def create_params
      p = params.require(:post).permit(:id, :title, :permalink, :content, :meta_keywords)
      p[:user_id] = session[:user_id]
      case params.require(:status)
        when "Draft"
           p[:status] = "DRAFT"
        
        when "Publish"
           p[:status] = "PUBLIC"
        
        when "Publish for users"
          p[:status] = "USERS"
        else
          flash[:error] = "Sorry, we have an internal Error."
          redirect_to new_admin_post_path
      end

      p
    end
end
