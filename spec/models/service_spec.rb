require 'rails_helper'

RSpec.describe Service, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      service = build(:service)
      expect(service).to be_valid
    end

    it 'is not valid without a title' do
      service = build(:service, title: nil)
      expect(service).not_to be_valid
    end

    it 'is not valid without a description' do
      service = build(:service, description: nil)
      expect(service).not_to be_valid
    end
  end

  # describe 'associations' do
  #   it 'has many options' do
  #     service = create(:service)
  #     option1 = create(:option, service:)
  #     option2 = create(:option, service:)
  #     expect(service.options).to include(option1, option2)
  #   end

  #   it 'has many images attached' do
  #     service = create(:service)
  #     expect(service.images.attached?).to be_truthy
  #     expect(service.images.count).to eq(2)
  #   end

  #   it 'has many users' do
  #     service = create(:service)
  #     user1 = create(:user, service:, role: Role.find_or_create_by(name: 'employee'))
  #     user2 = create(:user, service:, role: Role.find_or_create_by(name: 'employee'))
  #     expect(service.users).to include(user1, user2)
  #   end
  # end
end
