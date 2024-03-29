class PostsController < ApplicationController
  ERR404 = "#{Rails.root}/public/404.html"
  
  def index

    page = params[:page] == nil ? 1 : params[:page].to_i
    limit = 3 #<<< set by options an db

    if page == 0
      return render file: ERR404
    end

    if session[:user_id]
      @posts = Post.page_users(page,limit)
  
      post_count = Post.users_post_count

      if @posts.blank?
        return render file: ERR404
      end
    else #--------------- else -----------
      @posts = Post.page_public(page,limit)
  
      post_count = Post.public_post_count
      
      if @posts.blank?
        return render file: ERR404
      end
    end
    
    if post_count < limit
      @page_num = 1
    elsif (post_count % limit) == 0
      @page_num = post_count / limit
    else
      @page_num = (post_count / limit) + 1
    end
    
    puts page
    @current_page = page
  end
# --------------------------------
  def show
    post_content = Post.post_by_permalink(params[:permalink])

    unless post_content
      render file: ERR404
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
    @parent_comments = Comment.parent_comments(@post.id)
  end
# --------------------------------
  def show_page
    page_content = Post.page_by_permalink(params[:permalink])

    unless page_content
      render file: ERR404
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
    #   render ERR404
    # end
  end
# --------------------------------
  def search
    page = params[:page] != nil ? params[:page].to_i : 1
    limit = 3 # set by otions
    if session[:user_id]
      @posts = Post.search_for_users(params[:query],page,limit)
    else
      @posts = Post.search_for_public(params[:query],page,limit)
    end       

    if @posts.blank?
      render file: ERR404
    end
  end
# --------------------------------
  def comment

    comment = Comment.new(commnet_params)
    permalink = params[:permalink]

    if comment.save
      flash[:comment_notice] = "Your Comment Successfuly Published."
      return redirect_to post_path(permalink)
    else
      flash[:comment_error] = "Sorry, we have an error!"
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
