class HomeController < ApplicationController
  expose :posts, -> {
    Post.includes(:user, :tags, :rich_text_description)
      .published.paginate(page: params[:page], per_page: 12)
  }

  def index
    render template: 'posts/index'
  end
end
