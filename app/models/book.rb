class Book
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :slug, type: String

  field :author_name, type: String
  field :description, type: String
  field :image, type: String
  mount_uploader :image, BookPreviewUploader
  field :available, type: Boolean, default: true
  field :average_rating, type: Float, default: 0
  field :likes_count, type: Integer, default: 0
  field :taken_count, type: Integer, default: 0

  has_many :comments, dependent: :destroy
  has_many :histories, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :name, :author_name, :description, :image, presence: true
  validates :name, :slug, uniqueness: true
  validates :description, length: { maximum: 1000 }

  index({ average_rating: -1 })
  index({ slug: 1 })

  before_save :set_slug
  def to_param
    slug
  end

  def liked_by?(user)
    likes.where(user: user).exists?
  end

  def bookmarked_by?(user)
    bookmarks.where(user: user).exists?
  end

  def borrow_book(user)
    return false unless available

    histories.create(user: user, taken_at: Time.current) && update(available: false)
  end

  def return_book
    history = histories.where(returned_at: nil).last
    return false unless history

    history.update(returned_at: Time.current)
    update(available: true)
  end

  private

  def set_slug
    self.slug = name.parameterize
  end
end
