class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]
  before_action :set_book, only: %i[create]

  def index
    @comments = Comment.all
  end

  def show; end

  def new
    @comment = Comment.new
  end

  def edit; end

  def create
    @comment = @book.comments.new(comment_params.merge(user_id: current_user.id))

    if @comment.save
      redirect_to @book, notice: 'Comment was successfully created.'
    else
      flash.now[:alert] = 'Comment was not created.'
      render :index
    end
  end

  def update; end

  def destroy; end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_book
    @book = Book.find_by(slug: params[:book_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
