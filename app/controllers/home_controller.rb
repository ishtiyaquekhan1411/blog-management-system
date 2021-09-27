class HomeController < ApplicationController
  expose :posts, -> { Post.includes(:user).published }

  def index
    render template: 'posts/index'
  end
end
