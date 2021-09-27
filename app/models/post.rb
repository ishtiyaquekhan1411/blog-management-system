class Post < ApplicationRecord
  belongs_to :user

  validates :title, :description, presence: true

  enum status: %i[draft published], _default: 'draft'

  scope :own_posts, -> (user) { where(user_id: user.id) }
end
