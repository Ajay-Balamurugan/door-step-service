require 'rails_helper'

RSpec.describe EmployeeSlot, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:service_request_item_id) }
    it { should validate_presence_of(:time_slot) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:service_request_item) }
  end

  describe 'after_create callback' do
    let(:employee_slot) { create(:employee_slot) }

    it 'updates the service_request_item status to employee_assigned' do
      expect(employee_slot.service_request_item.status).to eq('employee_assigned')
    end

    it 'sends an email to the employee' do
      expect(SlotMailer).to have_received(:with).with(employee_slot:)
      expect(SlotMailer).to have_received(:new_slot)
      expect(SlotMailer.deliveries.last.to).to include(employee_slot.user.email)
    end
  end
end
