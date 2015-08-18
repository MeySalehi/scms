class AuthorsController < ApplicationController
  def index
    limit = 4 #set by options
  	page = params[:page]
		
		if page == nil
      page = 1
      @authors = User.list(page, limit)
    
    elsif page.to_i == (0 && 1)
	  	return redirect_to authors_path
	  elsif page.to_i > 1
      page = page.to_i
      @authors = User.list(page, limit)
      puts @authors
	  end

    authors_count = User.where(profile_visible: true).count
    
    if authors_count < limit
      @page_num = 1
    elsif (authors_count % limit) == 0
      @page_num = authors_count / limit
    else
      @page_num = (authors_count / limit) + 1
    end

    @current_page = page
  end
  
  def profile

  	@author = User.find_by(username: params[:username])
  	@author_posts = @author.posts
  end
end
