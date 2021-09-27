class PostsController < ApplicationController
  expose :posts, -> { get_all_posts }
  expose :post

  before_action :authenticate_user!, except: %i[index show]
  before_action only: %i[edit update destroy] do
    authorize post
  end

  def create
    post.user = current_user
    if post.save!
      redirect_to(posts_path(own_posts: true), notice: t('.new_post_created'))
    else
      render(:new)
    end
  end

  def destroy
    post.destroy
    redirect_to posts_path(own_posts: true), notice: t('.deleted_successfully')
  end

  def update
    if post.update(post_params)
      redirect_to post_path(post.id), notice: t('.post_updated')
    else
      render :edit
    end
  end

  def publish
    if post.draft?
      post.published!
      redirect_to post_path(post.id), notice: t('.post_published_successfully')
    else
      render :edit
    end
  end

  private

  def get_all_posts
    params[:own_posts] ? current_user.posts.includes(:user) : Post.includes(:user).published
  end

  def post_params
    params.require(:post).permit(:title, :description, :main_image, :remove_main_image)
  end

  def authorize_user!
    authorize post
  end
end
