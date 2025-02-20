require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  subject(:bookmark) { build(:bookmark) }

  describe 'Validations' do
    it { expect(bookmark).to be_valid }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:book) }
  end
end
