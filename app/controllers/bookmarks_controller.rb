class BookmarksController < ApplicationController
  before_action :set_book, only: %i[create destroy]
  def create
    logger.info("PARAMS: #{params.inspect}")
    @bookmark = current_user.bookmarks.new(book_id: @book.id)
    if @bookmark.save
      redirect_to @book, notice: 'Bookmark was successfully created.'
    else
      render json: @bookmark.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = current_user.bookmarks.find_by(book_id: @book.id)
    if @bookmark&.destroy
      redirect_to @book, notice: 'Bookmark was successfully destroyed.'
    else
      render json: @bookmark.errors, status: :unprocessable_entity
    end
  end

  private

  def set_book
    logger.info("PARAMS: #{params[:book_id]}")
    @book = Book.find_by(slug: params[:book_id])
  end
end
