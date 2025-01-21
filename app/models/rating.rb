class Rating
  include Mongoid::Document
  include Mongoid::Timestamps

  field :stars, type: Integer

  belongs_to :book
  belongs_to :user

  validates :stars, numericality: { only_integer: true }, inclusion: { in: 1..5 }
  after_save :update_book_average_rating

  private

  def update_book_average_rating
    book_rating_sum = book.ratings.reduce(0) { |sum, rating| sum + rating.stars }
    book.update(average_rating: book_rating_sum.to_f / book.ratings.count)
  end
end
