class AuthorsController < ApplicationController
  def index
  	@authors = User.order("full_name asc")
  end

  def profile
  	@author = User.find_by_username(params[:username])
  	@author_posts = @author.posts
  end
end
#we need to add 2 column in user table: 1. public_email 2.porofile_visible