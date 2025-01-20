class Book
  include Mongoid::Document
  include Mongoid::Timestamps

  field :id, type: Integer
  field :name, type: String
  field :author_name, type: String
  field :description, type: String
  field :image, type: String
  mount_uploader :image, BookPreviewUploader
  field :status, type: String
  field :likes_count, type: Integer, default: 0
  field :taken_count, type: Integer, default: 0

  has_many :comments
  has_many :histories
  has_many :likes, as: :likeable
  validates :name, :author_name, :description, :status, presence: true
  validates_inclusion_of :status, in: %w[In Out], allow_blank: true
  def to_param
    URI.encode_www_form_component(name)
  end

  def liked_by?(user)
    likes.where(user: user).exists?
  end
end
