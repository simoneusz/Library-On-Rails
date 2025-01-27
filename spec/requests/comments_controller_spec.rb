require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:comment) { create(:comment, book: book, user: user) }

  before { sign_in user }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new comment' do
        expect do
          post :create, params: { book_id: book.slug, comment: attributes_for(:comment) }
        end.to change(Comment, :count).by(1)
      end

      it 'redirects to the book page' do
        post :create, params: { book_id: book.slug, comment: attributes_for(:comment) }
        expect(response).to redirect_to(book)
      end
    end
  end
end
