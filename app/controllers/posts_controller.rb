class PostsController < ApplicationController
  def index
    @posts = Post.recent_post(5)
  end

  def page

    @posts = Post.page(params[:id].to_i,2)
  end

  def show
    p = params[:id]
    @post = Post.find_by_permalink(p)

    unless @post
      render file: "#{Rails.root}/public/404.html"
    end
  end

  def category
    category = Category.find_by_name(params[:id])
    @posts = category.posts

    if @posts == []
      render file: "#{Rails.root}/public/404.html"
    end
  end

  def search
    @posts = Post.search(params[:id]).reverse

    if @posts == []
      render file: "#{Rails.root}/public/404.html"
    end

  end

  def comment
  end
end
