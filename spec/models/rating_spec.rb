require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:rating) { build(:rating) }

  describe 'Validations' do
    it { expect(rating).to be_valid }

    it { is_expected.to have_field(:stars).of_type(Integer) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:user) }
  end
end
