require 'rails_helper'

RSpec.describe Book, type: :model do
  subject(:book) { build(:book) }
  after(:all) do
    Book.destroy_all
  end
  describe 'Validations' do
    it { expect(book).to be_valid }

    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:author_name).of_type(String) }
    it { is_expected.to have_field(:description).of_type(String) }
    it { is_expected.to have_field(:description).of_type(String) }
    it { is_expected.to have_field(:available).of_type(Mongoid::Boolean).with_default_value_of(true) }
    it { is_expected.to have_field(:average_rating).of_type(Float).with_default_value_of(0) }
    it { is_expected.to have_field(:likes_count).of_type(Integer).with_default_value_of(0) }
    it { is_expected.to have_field(:taken_count).of_type(Integer).with_default_value_of(0) }

    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :author_name }
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_presence_of :image }

    it { is_expected.to validate_uniqueness_of :name }
    it { is_expected.to validate_uniqueness_of :slug }
    it { is_expected.to validate_length_of(:description).with_maximum(1000) }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:comments).with_dependent(:destroy) }
    it { is_expected.to have_many(:histories).with_dependent(:destroy) }
    it { is_expected.to have_many(:ratings).with_dependent(:destroy) }
    it { is_expected.to have_many(:likes).with_dependent(:destroy) }
    it { is_expected.to have_many(:bookmarks).with_dependent(:destroy) }
  end

  describe 'Instance methods' do
    let(:user) { create(:user) }

    describe '#liked_by?' do
      it 'returns true if the user has liked the book' do
        book.save!
        book.likes.create(user: user)
        expect(book.liked_by?(user)).to be(true)
      end

      it 'returns false if the user has not liked the book' do
        expect(book.liked_by?(user)).to be(false)
      end
    end

    describe '#bookmarked_by?' do
      it 'returns true if the user has bookmarked the book' do
        book.save!
        book.bookmarks.create(user: user)
        expect(book.bookmarked_by?(user)).to be(true)
      end

      it 'returns false if the user has not bookmarked the book' do
        expect(book.bookmarked_by?(user)).to be(false)
      end
    end

    describe '#borrow_book' do
      it 'marks the book as unavailable and creates a history record if available' do
        book.save!
        expect { book.borrow_book(user) }.to change { book.histories.count }.by(1)
        expect(book.available).to be(false)
      end

      it 'does not borrow the book if it is unavailable' do
        book.update!(available: false)
        expect(book.borrow_book(user)).to be(false)
      end
    end

    describe '#return_book' do
      it 'marks the book as available and updates the history record' do
        book.save!
        book.borrow_book(user)
        history = book.histories.last

        expect { book.return_book }.to change { history.reload.returned_at }.from(nil)
        expect(book.available).to be(true)
      end
    end
  end

  describe 'Callbacks' do
    it 'sets the slug before saving' do
      book.save!
      book.name = 'Changed book name'
      book.save!
      expect(book.slug).to eq('changed-book-name')
    end
  end
end
