require 'rails_helper'

RSpec.describe Services::BookingService::BookingCreator do
  describe '#create_booking' do
    let(:user) { create(:user, :customer) }
    let(:service_request) { create(:service_request, user:) }
    let(:option1) { create(:option) }
    let(:option2) { create(:option) }

    before do
      create(:service_request_item, user:, option: option1, order_placed: false)
      create(:service_request_item, user:, option: option2, order_placed: false)
    end

    it 'updates the service_request_items with the service_request_id and order_placed status' do
      booking_creator = described_class.new(user.id, service_request)
      booking_creator.create_booking

      service_request_items = ServiceRequestItem.where(user:, order_placed: true)
      expect(service_request_items.pluck(:service_request_id).uniq).to eq([service_request.id])
      expect(service_request_items.pluck(:status).uniq).to eq(['order_placed'])
    end
  end
end
