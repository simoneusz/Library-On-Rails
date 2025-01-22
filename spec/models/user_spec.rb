require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      p user.username
      expect(user).to be_valid
    end
  end
end
