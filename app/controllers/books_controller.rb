class BooksController < ApplicationController
  helper ApplicationHelper
  before_action :set_book, only: %i[show edit update destroy like update_rating borrow return]
  rescue_from Mongoid::Errors::DocumentNotFound, with: :record_not_found
  add_breadcrumb '<i class="bi bi-house"></i>'.html_safe, :root_path
  add_breadcrumb 'books', :books_path
  def index
    @top_books = Book.order_by(average_rating: :desc).limit(7)
    @books = Book.page(params[:page]).per(20)
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def show
    add_breadcrumb @book.name, book_path(@book)
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    # redirect_to books_url, notice: 'Book was successfully deleted.'
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.js
    end
  end

  def like
    if @book.liked_by?(current_user)
      @book.likes.where(user: current_user).destroy_all
      @book.inc(likes_count: -1) if @book.likes.count.positive?
    else
      @book.likes.create!(user: current_user)
      @book.inc(likes_count: 1)
    end
    redirect_to @book
  end

  def bookmark
    if @book.bookmarked_by?(current_user)
      @book.bookmarks.where(user: current_user).destroy_all
    else
      @book.bookmarks.create!(user: current_user)
    end
    redirect_to @book
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
