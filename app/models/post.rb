class Post < ApplicationRecord

  attr_accessor :remove_main_image
  acts_as_taggable_on :tags

  enum status: %i[draft published], _default: 'draft'

  belongs_to :user
  has_rich_text :description
  has_one_attached :main_image

  validates :title, :description, presence: true
  validates :main_image, content_type: %w[image/png image/jpg image/jpeg],
    dimension: { width: 1000, height: 1500 }

  before_update :write_published_at, if: :will_save_change_to_status?

  scope :own_posts, -> (user) { where(user_id: user.id) }

  def remove_main_image?
    remove_main_image == '1'
  end

  private

  def write_published_at
    return if status_in_database.eql?('published')

    self.published_at = Time.now
  end
end
