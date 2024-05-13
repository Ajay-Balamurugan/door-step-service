require 'rails_helper'

RSpec.describe Role, type: :model do
  describe 'associations' do
    it 'has many users' do
      role = FactoryBot.create(:role)
      user1 = FactoryBot.create(:user, role:)
      user2 = FactoryBot.create(:user, role:)
      expect(role.users).to include(user1, user2)
    end
  end
end
