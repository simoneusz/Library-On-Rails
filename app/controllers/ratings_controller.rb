class RatingsController < ApplicationController
  before_action :set_book, only: [:create]
  def create
    @rating = @book.ratings.find_or_create_by(user: current_user)

    if @rating.update(rating_params)
      flash[:notice] = 'Thanks for your rating!'
    else
      flash[:alert] = @rating.errors.full_messages.to_sentence
    end

    redirect_to book_path(@book)
  end

  private

  def rating_params
    params.require(:rating).permit(:stars)
  end

  def set_book
    @book = Book.find_by(slug: params[:book_id])
  end
end
