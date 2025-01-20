class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy like]
  rescue_from Mongoid::Errors::DocumentNotFound, with: :record_not_found
  def index
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
