class HomeController < ApplicationController
  expose :posts, -> { Post.includes(:user) }

  def index
    @posts = posts.published
    render template: 'posts/index'
  end
end
