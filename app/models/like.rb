class Like
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :likeable, polymorphic: true
  after_create :update_likable_likes

  private

  def update_likable_likes
    likeable.likes_count = likeable.likes.count
  end
end
