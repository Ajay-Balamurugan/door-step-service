require 'rails_helper'

RSpec.describe ServiceRequest, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      service_request = FactoryBot.create(:service_request)
      expect(service_request).to be_valid
    end

    it 'is not valid without a total' do
      service_request = FactoryBot.build(:service_request, total: nil)
      expect(service_request).not_to be_valid
    end

    it 'is not valid without a user_id' do
      service_request = FactoryBot.build(:service_request, user_id: nil)
      expect(service_request).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      service_request = FactoryBot.build(:service_request)
      expect(service_request.user).to be_a(User)
    end

    # it 'has many service_request_items' do
    #   service_request = create(:service_request)
    #   service_request_item1 = create(:service_request_item, service_request: service_request)
    #   service_request_item2 = create(:service_request_item, service_request: service_request)
    #   expect(service_request.service_request_items).to include(service_request_item1, service_request_item2)
    # end

    # it 'has many options through service_request_items' do
    #   service_request = create(:service_request)
    #   option1 = create(:option)
    #   option2 = create(:option)
    #   service_request_item1 = create(:service_request_item, service_request: service_request, option: option1)
    #   service_request_item2 = create(:service_request_item, service_request: service_request, option: option2)
    #   expect(service_request.options).to include(option1, option2)
    # end
  end
end
