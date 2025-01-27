require 'rails_helper'

RSpec.describe BookmarksController, type: :controller do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  before do
    sign_in user
  end
  after do
    User.destroy_all
    Book.destroy_all
  end

  describe 'POST #create' do
    context 'when bookmark is successfully created' do
      it 'creates a new bookmark and redirects to the book page' do
        expect do
          post :create, params: { book_id: book.slug }
        end.to change(user.bookmarks, :count).by(1)

        expect(response).to redirect_to(book)
        expect(flash[:notice]).to eq('Bookmark was successfully created.')
      end
    end

    context 'when bookmark creation fails' do
      before do
        allow_any_instance_of(Bookmark).to receive(:save).and_return(false)
      end

      it 'returns unprocessable_entity status' do
        post :create, params: { book_id: book.slug }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:bookmark) { create(:bookmark, user: user, book: book) }

    context 'when bookmark is successfully destroyed' do
      it 'removes the bookmark and redirects to the book page' do
        expect do
          delete :destroy, params: { book_id: book.slug }
        end.to change(user.bookmarks, :count).by(-1)

        expect(response).to redirect_to(book)
        expect(flash[:notice]).to eq('Bookmark was successfully destroyed.')
      end
    end

    context 'when bookmark destruction fails' do
      before do
        allow_any_instance_of(Bookmark).to receive(:destroy).and_return(false)
      end

      it 'returns unprocessable_entity status' do
        delete :destroy, params: { book_id: book.slug }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
