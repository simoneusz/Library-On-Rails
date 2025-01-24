require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe 'Validations' do
    it { expect(user).to be_valid }

    it { is_expected.to have_field(:username).of_type(String) }
    it { is_expected.to have_field(:email).of_type(String).with_default_value_of('') }
    it { is_expected.to have_field(:encrypted_password).of_type(String).with_default_value_of('') }
    it { is_expected.to have_field(:reset_password_token).of_type(String) }
    it { is_expected.to have_field(:reset_password_sent_at).of_type(Time) }
    it { is_expected.to have_field(:remember_created_at).of_type(Time) }

    it { is_expected.to validate_presence_of :username }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:comments).with_dependent(:destroy) }
    it { is_expected.to have_many(:histories).with_dependent(:destroy) }
    it { is_expected.to have_many(:likes).with_dependent(:destroy) }
    it { is_expected.to have_many(:bookmarks).with_dependent(:destroy) }
  end
end
