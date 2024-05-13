require 'rails_helper'

RSpec.describe ServiceRequestItem, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      service_request_item = FactoryBot.create(:service_request_item)
      expect(service_request_item).to be_valid
    end

    it 'is not valid without an option_id' do
      service_request_item = FactoryBot.build(:service_request_item, option: nil)
      expect(service_request_item).not_to be_valid
    end

    it 'is not valid with a time_slot in the past' do
      past_time_slot = 'Wed, 9 May 2023 10:55:00.000000000 UTC +00:00'
      service_request_item = FactoryBot.build(:service_request_item, time_slot: past_time_slot)
      expect(service_request_item).not_to be_valid
    end

    it 'is not valid with a time_slot outside the allowed range' do
      invalid_time_slot = 'Wed, 22 May 2024 06:55:00.000000000 UTC +00:00'
      service_request_item = FactoryBot.build(:service_request_item, time_slot: invalid_time_slot)
      expect(service_request_item).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a service_request' do
      service_request_item = FactoryBot.build(:service_request_item)
      expect(service_request_item.service_request).to be_a(ServiceRequest)
    end

    it 'belongs to an option' do
      service_request_item = FactoryBot.build(:service_request_item)
      expect(service_request_item.option).to be_a(Option)
    end

    it 'belongs to a user' do
      service_request_item = FactoryBot.build(:service_request_item)
      expect(service_request_item.user).to be_a(User)
    end
  end
end
