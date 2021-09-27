class Post < ApplicationRecord

  attr_accessor :remove_main_image

  enum status: %i[draft published], _default: 'draft'

  belongs_to :user
  has_rich_text :description
  has_one_attached :main_image

  validates :title, :description, presence: true
  validates :main_image, attached: true, content_type: %w[image/png image/jpg image/jpeg],
    dimension: { width: 1000, height: 1500 }

  before_update :write_published_at, if: :will_save_change_to_status?
  after_update :purge_main_image, if: :remove_main_image?

  scope :own_posts, -> (user) { where(user_id: user.id) }

  private

  def remove_main_image?
    remove_main_image == '1'
  end

  def purge_main_image
    main_image.purge
  end

  def write_published_at
    return if status_in_database.eql?('published')

    self.published_at = Time.now
  end
end
