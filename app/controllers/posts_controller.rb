class PostsController < ApplicationController
  expose :posts, -> { Post.includes(:user) }

  before_action :authenticate_user!

  def index
    @posts = params[:own_posts] ? posts.own_posts(current_user) : posts.published
  end

  def new
  end

  def create
  end

  def show
  end

  def delete
  end

  def edit
  end

  def update
  end
end
