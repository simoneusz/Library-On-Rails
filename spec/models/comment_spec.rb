require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  subject(:comment) { build(:comment) }

  describe 'Validations' do
    it { expect(comment).to be_valid }

    it { is_expected.to validate_length_of(:content).within(3..140) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:book) }
  end
end
