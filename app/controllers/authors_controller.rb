class AuthorsController < ApplicationController
  def index
	  @authors = User.list(1 , 4)
  end

  def page
  	page = params[:id].to_i
		
		if page == ( 0 or nil )
	  	redirect_to :controller => "authors", :action => "index"
	  else
	  	@authors = User.list(page, 4)
	  end
  end
  
  def profile
  	@author = User.find_by_username(params[:username])
  	@author_posts = @author.posts
  end
end
