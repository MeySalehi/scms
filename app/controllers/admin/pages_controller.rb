class Admin::PagesController < ApplicationController
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
    @pages = Post.user_posts(user_id, page, limit, "PAGE")

    page_count = Post.user_posts_count(user_id, "PAGE")

    if page_count < limit
      @page_num = 1
    elsif (page_count % limit) == 0
      @page_num = page_count / limit
    else
      @page_num = (page_count / limit) + 1
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
    @page = Post.new
  end
  #---------------------------------------------------  
  def create
    params = create_params()
    new_page = Post.new(params)
    if new_page.save
      flash[:notice] = "'#{params[:title]}' Successfully created."
      return redirect_to admin_pages_path
    else
      flash[:erroe] = "Sorry, we have an internal error for create '#{params[:title]}'."
      return redirect_to new_admin_page_path
    end
  end
  #---------------------------------------------------
  def edit  
    @page = Post.where(id: params[:id].to_i, type_set: "PAGE").first
  end

  def update
    # params = create_params
    page = Post.where(id: params[:id].to_i, type_set: "PAGE").first
    
    if page.update(create_params)
      flash[:notice] = "'#{params[:title]}' Successfully edited."
      return redirect_to admin_pages_path
    else
      flash[:erroe] = "Sorry, we have an internal error for edit '#{params[:title]}'."
      return redirect_to new_admin_page_path
    end
  end
  #---------------------------------------------------
  def delete
    page = Post.find_by(id: params[:id].to_i)
    if !page.blank?
      @page = page
    else
      return render ERR404
    end
  end
  #---------------------------------------------------
  def destroy
    page = Post.find_by(id: params[:page][:id].to_i)
    if page.destroy
      flash[:notice] = "page Successfully Deleted!"
      return redirect_to admin_pages_path
    else
      flash[:error] = "We have an internal Error, please try again!"
      return redirect_to admin_pages_path
    end
  end
  #---------------------------------------------------

  private
    def create_params
      p = params.require(:page).permit(:id, :title, :permalink, :content, :meta_keywords)
      p[:user_id] = session[:user_id]
      p[:type_set] = "PAGE"
      case params.require(:status)
        when "Draft"
           p[:status] = "DRAFT"
        
        when "Publish"
           p[:status] = "PUBLIC"
        
        when "Publish for users"
          p[:status] = "USERS"
        else
          flash[:error] = "Sorry, we have an internal Error."
          redirect_to new_admin_page_path
      end

      p
    end
end
