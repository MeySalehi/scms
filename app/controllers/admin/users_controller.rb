class Admin::UsersController < ApplicationController
  before_action :confirm_logged_in
  before_action :confrim_access_level

  ERR404 = "#{Rails.root}/public/404.html"
  #------------------------------------------
	def index
    limit = 3 #set by options
    page = params[:page]
    if page == nil
      page = 1
    elsif page.to_i <= 0
      redirect_to page_admin_users_path(1)
    else
      page = page.to_i
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
  #------------------------------------------
  def show
    @user = User.find_by(username: params[:username])
    @recent_posts = @user.posts.where(type_set: "POST")
                                  .order(updated_at: :desc)
                                    .first(5)
    @recent_posts.each do |p|
      puts p.permalink
    end
    if @user.blank?
      return render ERR404
    end
  end
  #------------------------------------------
  def Profile
    @user = User.find_by(username: session[:username])
  end
  #------------------------------------------
  def edit
    case session[:access_level]
    when "ROOT"        
      user = User.find_by(username: params[:username])
      if !user.blank?
        @user = user
      else
        return render ERR404
      end
    when "ADMIN"
      user = User.find_by(username: params[:username])
      if !user.blank? and user.access_level == "USER"
        @user = user
      else
        return render ERR404
      end
    when params[:username]
      @user = User.find_by(username: session[:username])
    else
      return render ERR404
    end
  end
  #------------------------------------------
  def update
    update_params = update_params()
    if !update_params.blank?
      user = User.find_by(username: update_params[:username])
      if user.update(update_params)
        flash[:notice] = "#{update_params[:full_name]} Profile Successfully Updated"
        return redirect_to admin_user_path(params[:username])
      else
        flash[:error] = "Internal Server Error!"
        return redirect_to edit_admin_user_path(params[:username])
      end
    else
      flash[:error] = "Internal Server Error! update_params is blank"
      return redirect_to edit_admin_user_path(params[:username])
    end
  end
  #------------------------------------------
  def new
    @user = User.new()    
  end
  #------------------------------------------
  def create
    user = User.new(create_params)
    if user.save
      flash[:notice] = "#{user.full_name} Account Successfully created."
      return redirect_to admin_user_path(user.username)
    else
      flash[:error] = "Server Internal Error."
      return redirect_to new_admin_user_path
    end    
  end
  #------------------------------------------
  def delete
    @user = User.find_by(username: params[:username])
    if @user.blank?
      return render ERR404
    end
  end
  #------------------------------------------
  def destroy
    @user = User.find_by(username: params[:user][:username])

    if !@user.blank?
      # cash full_name for flash:
      full_name = @user.full_name
      # Now go to destroy!
      @user.posts.destroy_all
      @user.destroy
      flash[:notice] = "#{full_name} Profile Successfully Deleted!"
      return redirect_to admin_users_path
    else
      flash[:error] = "Server Internal Error in Delete Account."
      return redirect_to admin_users_path
    end
  end
#=====================================================================
  private
    def update_params
      if params[:user][:username] == session[:username]
        p = params.require(:user)
              .permit(:full_name, :username, :bio, :email, :public_email, :avatar)
      
      elsif session[:access_level] == "ROOT"
        p = params.require(:user)
              .permit(:full_name, :username, :bio, :email, :public_email, :access_level, :avatar)
      
      elsif session[:access_level] == "ADMIN" and params[:user][:access_level] == "USER"
        p = params.require(:user)
              .permit(:full_name, :username, :bio, :email, :public_email, :avatar)
      
      else
        p = nil
      end
      return p      
    end
    #---------------------------------------------
    def create_params
      p = params.require(:user)
                  .permit(:username,
                          :password,
                          :full_name,
                          :email,
                          :public_email,
                          :bio,
                          :profile_visible,
                          :avatar,
                          :access_level)


      # Upload avatar and save avatar image path
      return p
    end
    #---------------------------------------------
    def upload(file_io, username)
      uploaded_io = file_io
      puts '************** #{username}_#{uploaded_io.original_filename} ***********'
      File.open(Rails.root.join('public', 'avatars', '#{username}_#{uploaded_io.original_filename}'), 'wb') do |file|
        file.write(uploaded_io.read)
      end
      return username + "_avatar"
    end
    # before action ------------------------------
    def confrim_access_level
      if session["access_level"] == "ROOT" or "ADMIN"
        return true
      else
        render file: "#{Rails.root}/public/404.html"
        return false
      end
    end
end
