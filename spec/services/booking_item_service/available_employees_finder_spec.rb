require 'rails_helper'

RSpec.describe Services::BookingItemService::AvailableEmployeesFinder do
  describe '#find_available_employees' do
    let(:service) { create(:service) }
    let(:option) { create(:option, service:, duration: 2) }
    let(:service_request_item) do
      create(:service_request_item, option:, time_slot: 'Wed, 22 May 2024 18:00:00.000000000 UTC +00:00')
    end
    let(:employee1) { create(:user, :employee, service:) }
    let(:employee2) { create(:user, :employee, service:) }
    let(:employee3) { create(:user, :employee, service:) }

    before do
      create(:employee_slot, user: employee1, service_request_item:,
                             time_slot: service_request_item.time_slot)
    end

    it 'returns available employees' do
      available_employees_finder = described_class.new(service_request_item, option)
      available_employees = available_employees_finder.find_available_employees

      expect(available_employees).to include(employee2, employee3)
      expect(available_employees).not_to include(employee1)
    end
  end
end
