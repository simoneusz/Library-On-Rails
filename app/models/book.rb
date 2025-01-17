class Book
  include Mongoid::Document
  include Mongoid::Timestamps

  field :id, type: Integer
  field :name, type: String
  field :author_name, type: String
  field :description, type: String
  field :image, type: String
  field :status, type: String
  field :likes_count, type: Integer, default: 0
  field :taken_count, type: Integer, default: 0

  has_many :comments
  has_many :histories

  validates :name, :author_name, :description, :status, presence: true
end
