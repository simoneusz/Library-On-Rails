require 'rails_helper'

RSpec.describe RatingsController, type: :controller do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  before { sign_in user }

  describe 'POST #create' do
    context 'when rating is created successfully' do
      it 'creates a new rating for the book' do
        expect do
          post :create, params: { book_id: book.slug, rating: { stars: 4 } }
        end.to change(Rating, :count).by(1)
      end

      it 'associates the rating with the current user' do
        post :create, params: { book_id: book.slug, rating: { stars: 4 } }
        rating = Rating.last
        expect(rating.user).to eq(user)
        expect(rating.book).to eq(book)
      end

      it 'updates the flash notice' do
        post :create, params: { book_id: book.slug, rating: { stars: 4 } }
        expect(flash[:notice]).to eq('Thanks for your rating!')
      end

      it 'redirects to the book page' do
        post :create, params: { book_id: book.slug, rating: { stars: 4 } }
        expect(response).to redirect_to(book_path(book))
      end
    end

    context 'when rating already exists' do
      let!(:existing_rating) { create(:rating, book: book, user: user, stars: 3) }

      it 'does not create a new rating' do
        expect do
          post :create, params: { book_id: book.slug, rating: { stars: 5 } }
        end.not_to change(Rating, :count)
      end

      it 'updates the existing rating' do
        post :create, params: { book_id: book.slug, rating: { stars: 5 } }
        existing_rating.reload
        expect(existing_rating.stars).to eq(5)
      end
    end

    context 'when rating fails to save' do
      it 'does not create a new rating' do
        allow_any_instance_of(Rating).to receive(:update).and_return(false)
        expect do
          post :create, params: { book_id: book.slug, rating: { stars: nil } }
        end.not_to change(Rating, :count)
      end

      it 'sets a flash alert with error messages' do
        post :create, params: { book_id: book.slug, rating: { stars: nil } }
        expect(flash[:alert]).to include('Stars is not a number and Stars is not included in the list')
      end

      it 'redirects to the book page' do
        post :create, params: { book_id: book.slug, rating: { stars: nil } }
        expect(response).to redirect_to(book_path(book))
      end
    end
  end
end
