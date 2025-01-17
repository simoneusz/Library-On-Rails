class BooksController < ApplicationController
  rescue_from Mongoid::Errors::DocumentNotFound, with: :record_not_found
  def index
    @books = Book.page(params[:page]).per(5)
  end

  def show
    @book = Book.find_by!(name: URI.decode_www_form_component(params[:id].to_s))
  end

  private

  def record_not_found
    render file: "#{Rails.root}/public/404.html", status: :not_found
  end
end
