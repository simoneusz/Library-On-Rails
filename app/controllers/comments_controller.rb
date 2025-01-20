class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]
  before_action :set_book, only: %i[create]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show; end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit; end

  # POST /comments or /comments.json
  def create
    @comment = @book.comments.new(comment_params.merge(user_id: current_user.id))

    if @comment.save
      redirect_to @book, notice: 'Comment was successfully created.'
    else
      flash.now[:alert] = 'Comment was not created.'
      render :index
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update; end

  # DELETE /comments/1 or /comments/1.json
  def destroy; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_book
    @book = Book.find_by(slug: params[:book_id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:content)
  end
end
