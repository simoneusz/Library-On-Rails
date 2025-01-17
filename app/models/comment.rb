class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String

  belongs_to :post
  belongs_to :user
  belongs_to :book

  validates :name, presence: true
end
