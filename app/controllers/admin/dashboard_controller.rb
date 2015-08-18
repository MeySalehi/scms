class Admin::DashboardController < ApplicationController

	before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]
	# ---------------------------------------------------
	def index
		@activity = Hash.new
		@activity[:posts] = Post.posts_count
		@activity[:comments] = Comment.count
		@activity[:pages] = Post.pages_count
	end
	# ---------------------------------------------------
	def login
	
	end
	# ---------------------------------------------------
	def attempt_login
		if params[:login][:username].present? && params[:login][:password].present?
			
			found_user = User.where(:username => params[:login][:username]).first

			if found_user
				authorized_user = found_user.authenticate(params[:login][:password])
			end
		end
		if authorized_user
			# mark user as logged in
			session[:user_id]		= authorized_user.id
			session[:username]	= authorized_user.username
			session[:full_name]	= authorized_user.full_name
			session[:access_level] = authorized_user.access_level
			flash[:notice] = "Welcome #{authorized_user.full_name}."
			redirect_to admin_dashboard_index_path
		else
			flash[:error] = "Invalid username/password combination."
			redirect_to login_path
		end
	end
	# ---------------------------------------------------
	def logout
		# mark user as logged out
		session[:user_id]		= nil
		session[:username]	= nil
		session[:full_name]	= nil

		flash[:notice] = "logged out!"
		redirect_to admin_login_path
	end
	# ---------------------------------------------------
	def draft
		draft_params = params.require(:draft).permit(:user_id, :status, :type_set, :title)
		draft_params[:user_id] = draft_params[:user_id].to_i

		puts draft_params
		draft = Post.new(draft_params)
		
		if draft.save
			flash[:notice] = "'#{draft_params[:title]}' Successfully Created!"
			redirect_to admin_dashboard_index_path
		else
			flash[:error] = "Unfortantly, we have on error"
			redirect_to admin_dashboard_index_path
		end
	end
	# ---------------------------------------------------
end
