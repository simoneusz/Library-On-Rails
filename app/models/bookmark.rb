class Bookmark
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true
  validates :book_id, uniqueness: { scope: :user_id, message: 'already bookmarked' }
end
