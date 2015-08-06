class PostsController < ApplicationController
  def index
    if session[:user_id]
      @posts = Post.users_recent_post(5)
    else
      @posts = Post.public_recent_post(5)
    end
  end
# --------------------------------
  def page
    if session[:user_id]
      @posts = Post.page_users(params[:id].to_i,10)
    else
      @posts = Post.page_public(params[:id].to_i,2)
    end
  end
# --------------------------------
  def show
    post_content = Post.post_by_permalink(params[:permalink])

    unless post_content
      render file: "#{Rails.root}/public/404.html"
    end

    if session[:user_id]
      @post = post_content
      @comment = Comment.new
    elsif post_content.status == "PUBLISH" 
      @post = post_content
      @comment = Comment.new
    else
      flash[:access_error] = "You Can't Access to this post, please login."
    end
  end
# --------------------------------
  def show_page
    page_content = Post.page_by_permalink(params[:permalink])

    unless page_content
      render file: "#{Rails.root}/public/404.html"
    end

    if session[:user_id]
      @page = page_content
      @comment = Comment.new
    elsif page_content.status == "PUBLISH" 
      @page = page_content
      @comment = Comment.new
    else
      flash[:access_error] = "You Can't Access to this page, please login."
    end
  end
# --------------------------------
  def category
    # need to re difine with data and testing
    
    # page = params[:id] != nil ? params[:id].to_i : 1
    # limit = 3 # set by otions
    # if session[:user_id]
    #   @posts = Category.category_for_users(params[:title],page,limit)
    # else
    #   @posts = Category.category_for_public(params[:title],page,limit)
    # end       

    # if @posts == []
    #   render file: "#{Rails.root}/public/404.html"
    # end
  end
# --------------------------------
  def search
    page = params[:id] != nil ? params[:id].to_i : 1
    limit = 3 # set by otions
    if session[:user_id]
      @posts = Post.search_for_users(params[:query],page,limit)
    else
      @posts = Post.search_for_public(params[:query],page,limit)
    end       

    if @posts == []
      render file: "#{Rails.root}/public/404.html"
    end
  end
# --------------------------------
  def comment

    comment = Comment.new(commnet_params)
    permalink = params[:permalink]

    if comment.save
      flash[:notice] = "Your Comment Successfuly Published."
      return redirect_to post_path(permalink)
    else
      flash[:error] = "Sorry, we have an error!"
      return redirect_to post_path(permalink)
    end

  end
# --------------------------------
  private
    def commnet_params
      p = params.require(:comment).permit(:post_id, :author, :author_url, :author_email, :content)
      p[:post_id] = p[:post_id].to_i
      p
    end
end
