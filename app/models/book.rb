class Book
  include Mongoid::Document
  include Mongoid::Timestamps

  field :id, type: Integer
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

  has_many :comments
  has_many :histories
  has_many :ratings
  has_many :likes, as: :likeable
  validates :name, :author_name, :description, presence: true

  before_save :set_slug
  def to_param
    slug
  end

  def liked_by?(user)
    likes.where(user: user).exists?
  end

  def borrow_book(user)
    return false unless available

    histories.create(user: user, taken_at: Time.current)
    update(available: false)
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
