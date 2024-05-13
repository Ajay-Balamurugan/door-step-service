require 'rails_helper'

RSpec.describe Option, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      option = FactoryBot.create(:option)
      expect(option).to be_valid
    end

    it 'is not valid without a title' do
      option = FactoryBot.build(:option, title: nil)
      expect(option).not_to be_valid
    end

    it 'is not valid without a description' do
      option = FactoryBot.build(:option, description: nil)
      expect(option).not_to be_valid
    end

    it 'is not valid without a price' do
      option = FactoryBot.build(:option, price: nil)
      expect(option).not_to be_valid
    end

    it 'is not valid without a duration' do
      option = FactoryBot.build(:option, duration: nil)
      expect(option).not_to be_valid
    end

    it 'is not valid with a duration less than 1 hour' do
      option = FactoryBot.build(:option, duration: 0)
      expect(option).not_to be_valid
    end

    it 'is not valid with a duration greater than 5 hours' do
      option = FactoryBot.build(:option, duration: 6)
      expect(option).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a service' do
      option = FactoryBot.build(:option)
      expect(option.service).to be_a(Service)
    end

    it 'has many service request items' do
      option = create(:option)
      service_request_item1 = create(:service_request_item, option:)
      service_request_item2 = create(:service_request_item, option:)
      expect(option.service_request_items).to include(service_request_item1, service_request_item2)
    end
  end
end
