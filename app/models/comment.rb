class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String

  belongs_to :user
  belongs_to :book

  validates :content, presence: true, length: { minimum: 3, maximum: 140 }
end
