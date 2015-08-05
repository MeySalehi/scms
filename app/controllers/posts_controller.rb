class PostsController < ApplicationController
  def index
    @posts = Post.recent_post(5)
  end

  def page

    @posts = Post.page(params[:id].to_i,2)
  end

  def show
    p = params[:permalink]
    @post = Post.find_by_permalink(p)

    unless @post
      render file: "#{Rails.root}/public/404.html"
    end
    @comment = Comment.new
  end

  def category
    category = Category.find_by_name(params[:title])
    @posts = category.posts

    if @posts == []
      render file: "#{Rails.root}/public/404.html"
    end
  end

  def search
    @posts = Post.search(params[:query]).reverse

    if @posts == []
      render file: "#{Rails.root}/public/404.html"
    end

  end

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

  private
    def commnet_params
      p = params.require(:comment).permit(:post_id, :author, :author_url, :author_email, :content)
      p[:post_id] = p[:post_id].to_i
      p
    end
end
