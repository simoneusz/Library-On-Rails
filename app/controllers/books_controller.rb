class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy like update_rating borrow return]
  rescue_from Mongoid::Errors::DocumentNotFound, with: :record_not_found
  def index
    # TODO: RANSACK
    # @q = Book.page(params[:page]).ransack(params[:q])
    # @books = @q.result.page(params[:page]).per(5)
    @books = Book.page(params[:page]).per(5)
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  def edit; end
  def show; end
  def update; end

  def destroy
    @book.destroy
    redirect_to books_url, notice: 'Book was successfully destroyed.'
  end

  def like
    if @book.liked_by?(current_user)
      @book.likes.where(user: current_user).destroy_all
      @book.inc(likes_count: -1)
    else
      @book.likes.create!(user: current_user)
      @book.inc(likes_count: 1)
    end

    respond_to do |format|
      format.html { redirect_to @book }
      format.js
    end
  end

  def borrow
    if @book.borrow_book(current_user)
      redirect_to @book, notice: 'Book borrowed successfully.'
    else
      redirect_to @book, notice: 'Book is unavailable.'
    end
  end

  def return
    if @book.return_book
      redirect_to @book, notice: 'Book returned successfully.'
    else
      redirect_to @book, notice: 'Error while returning book.'
    end
  end

  def update_rating
    @book.rating = @book.ratings
  end

  private

  def record_not_found
    render file: "#{Rails.root}/public/404.html", status: :not_found
  end

  def set_book
    @book = Book.find_by(slug: params[:id])
  end

  def book_params
    params.require(:book).permit(:name, :author_name, :description, :image)
  end
end
