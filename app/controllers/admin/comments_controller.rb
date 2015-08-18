class Admin::CommentsController < ApplicationController
  before_action :confirm_logged_in
  
  ERR404 = "#{Rails.root}/public/404.html"
  def index
    limit = 5 #set by options
    page = !params[:page].blank? && params[:page].to_i != 0 ? params[:page].to_i : 1
    post_id = params[:post_id] == nil ? nil : params[:post_id].to_i
    
    if post_id == nil
      user_id = session[:user_id]

      post_ids = User.user_posts(user_id)
      @comments = Comment.user_posts_comments(post_ids, page, limit)
      comment_count = Comment.user_posts_comments_count(post_ids)    
    elsif post_id == 0
      return render file: ERR404
    elsif post_id > 0  
      @comments = Comment.post_comments(post_id,page,limit)
      comment_count = Comment.post_comments_count(post_id)
      @post = Post.find_by(id: post_id)
      @post_id = post_id
    end

    if comment_count < limit
      @page_num = 0
    elsif (comment_count % limit) == 0
      @page_num = comment_count / limit
    else
      @page_num = (comment_count / limit) + 1
    end
    @current_page = page

  end

  def edit
    @comment = Comment.find(params[:id].to_i)
  end

  def update
    comment = Comment.find(params[:id].to_i)
    
    if comment.update(update_comment_params)
      flash[:notice] = "Comment successfully Edited!"
      return redirect_to admin_comments_path
    else
      flash[:error] = "Sorry, we have an internal error."
      return redirect_to edit_admin_comment(params[:id].to_i)
    end
  end

  def create
  end

  def delete
  end

  def destroy
  end
  
  private
    def update_comment_params
      p = params.require(:comment).permit(:content)
    end
end
