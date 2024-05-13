require 'rails_helper'

RSpec.describe Service, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      service = FactoryBot.create(:service)
      expect(service).to be_valid
    end

    it 'is not valid without a title' do
      service = FactoryBot.build(:service, title: nil)
      expect(service).not_to be_valid
    end

    it 'is not valid without a description' do
      service = FactoryBot.build(:service, description: nil)
      expect(service).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many options' do
      service = FactoryBot.create(:service)
      option1 = FactoryBot.create(:option, service:)
      option2 = FactoryBot.create(:option, service:)
      expect(service.options).to include(option1, option2)
    end

    it 'has many images attached' do
      service = create(:service)
      expect(service.images.attached?).to be_truthy
      expect(service.images.count).to eq(2)
    end

    it 'has many users' do
      service = FactoryBot.create(:service)
      user1 = FactoryBot.create(:user, service:)
      user2 = FactoryBot.create(:user, service:)
      expect(service.users).to include(user1, user2)
    end
  end
end
