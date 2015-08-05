class Admin::DashboardController < ApplicationController

	before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]
 
	def index
	
	end
	def login
	
	end
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

			flash[:notice] = "Welcome #{authorized_user.full_name}."
			puts "************* logged in **************"
			redirect_to admin_dashboard_index_path
		else
			flash[:error] = "Invalid username/password combination."
			puts "*************** Invalid **************"
			redirect_to admin_login_path
		end
	end
	def logout
		# mark user as logged out
		session[:user_id]		= nil
		session[:username]	= nil
		session[:full_name]	= nil

		flash[:notice] = "logged out!"
		redirect_to admin_login_path
	end
	def draft
	
	end
end
