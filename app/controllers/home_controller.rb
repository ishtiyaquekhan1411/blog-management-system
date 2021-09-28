class HomeController < ApplicationController
  expose :posts, -> {
    Post.includes(:user).published.paginate(page: params[:page], per_page: 10)
  }

  def index
    render template: 'posts/index'
  end
end
