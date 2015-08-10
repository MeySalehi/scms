class Admin::UsersController < ApplicationController
  before_action :confirm_logged_in
  before_action :confrim_access_level

  ERR404 = "#{Rails.root}/public/404.html"

	def index
    limit = 3 #set by options
    if params[:id] == nil
      page = 1
    elsif params[:id].to_i <= 0
      redirect_to page_admin_users_path(1)
    else
      page = params[:id].to_i
    end  
    
    user_count = User.all.count

    if user_count < limit
      @page_num = 1
    elsif (user_count % limit) == 0
      @page_num = user_count / limit
    else
      @page_num = (user_count / limit) + 1
    end
    
    @users = User.users_list(page,limit)
    @current_page = page
  end

  def show
    @user = User.find_by(username: params[:username])
    @recent_posts = @user.posts.where(type_set: "POST").order(updated_at: :desc).first(5)
    if @user.blank?
      return render ERR404
    end
  end

  def edit

  end

  def update
  end

  def create
  end

  def delete
  end

  def destroy
  end

  private
    def confrim_access_level
      if session["access_level"] == "ROOT" && "ADMIN"
        return true
      else
        render file: "#{Rails.root}/public/404.html"
        return false
      end
    end
end
