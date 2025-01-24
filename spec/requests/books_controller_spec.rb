require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:book) { create(:book) }
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  after do
    Book.destroy_all
  end
  describe 'GET #index' do
    it 'assigns and @books' do
      get :index
      expect(assigns(:books)).to be_a(Mongoid::Criteria)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'assigns a new book' do
      get :new
      expect(assigns(:book)).to be_a_new(Book)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new book and redirects to the show page' do
        expect do
          post :create, params: { book: attributes_for(:book) }
        end.to change(Book, :count).by(1)

        expect(response).to redirect_to(assigns(:book))
        expect(flash[:notice]).to eq('Book was successfully created.')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new book and re-renders the new template' do
        expect do
          post :create, params: { book: attributes_for(:book, name: nil) }
        end.not_to change(Book, :count)

        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested book to @book' do
      get :edit, params: { id: book.slug }
      expect(assigns(:book)).to eq(book)
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the book and redirects to the show page' do
        patch :update, params: { id: book.slug, book: { name: 'Updated Name' } }
        book.reload

        expect(book.name).to eq('Updated Name')
        expect(response).to redirect_to(book)
        expect(flash[:notice]).to eq('Book was successfully updated.')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the book and re-renders the edit template' do
        patch :update, params: { id: book.slug, book: { name: nil } }
        book.reload

        expect(book.name).not_to be_nil
        expect(response).to render_template(:edit)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the book and redirects to index' do
      book
      expect do
        delete :destroy, params: { id: book.slug }
      end.to change(Book, :count).by(-1)

      expect(response).to redirect_to(books_path)
      expect(flash[:notice]).to eq('Book was successfully destroyed.')
    end
  end

  describe 'POST #like' do
    before { sign_in(user) }

    context 'when the user likes a book' do
      it 'increments likes_count and creates a like' do
        expect do
          post :like, params: { id: book.slug }, xhr: true
        end.to change { book.likes.count }.by(1)

        expect(book.reload.likes_count).to eq(1)
        expect(response).to redirect_to(book)
      end
    end

    context 'when the user unlikes a book' do
      it 'decrements likes_count and removes the like' do
        book.likes.create!(user: user)
        expect do
          post :like, params: { id: book.slug }, xhr: true
        end.to change { book.likes.count }.by(-1)

        expect(book.reload.likes_count).to eq(0)
        expect(response).to redirect_to(book)
      end
    end
  end
end
