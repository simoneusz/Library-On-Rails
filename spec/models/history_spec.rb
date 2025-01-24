require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:history) { build(:history) }

  describe 'Validations' do
    it { expect(history).to be_valid }

    it { is_expected.to have_field(:taken_at).of_type(Time) }
    it { is_expected.to have_field(:returned_at).of_type(Time) }

    it { is_expected.to validate_presence_of :taken_at }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:user) }
  end
end
