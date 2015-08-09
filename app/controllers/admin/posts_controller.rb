class Admin::PostsController < ApplicationController
  before_action :confirm_logged_in
  def index
    limit = 5 # set by options
    page = params[:id].to_i == 0 ? 1 : params[:id].to_i
    user_id = session[:user_id].to_i
    @posts = Post.user_posts(user_id, page, limit)

    post_count = Post.user_posts_count(user_id)

    if post_count < limit
      @page_num = 1
    elsif (post_count % limit) == 0
      @page_num = post_count / limit
    else
      @page_num = (post_count / limit) + 1
    end
    @current_page = page
  end

  def new
    @post = Post.new
  end

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
