require 'rails_helper'

RSpec.describe EmployeeSlot, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      employee_slot = FactoryBot.create(:employee_slot)
      expect(employee_slot).to be_valid
    end

    it 'is not valid without a service_request_item_id' do
      employee_slot = FactoryBot.build(:employee_slot, service_request_item: nil)
      expect(employee_slot).not_to be_valid
    end

    it 'is not valid without a user_id' do
      employee_slot = FactoryBot.build(:employee_slot, user: nil)
      expect(employee_slot).not_to be_valid
    end

    it 'is not valid without a time_slot' do
      employee_slot = FactoryBot.build(:employee_slot, time_slot: nil)
      expect(employee_slot).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a service_request_item' do
      employee_slot = FactoryBot.build(:employee_slot)
      expect(employee_slot.service_request_item).to be_a(ServiceRequestItem)
    end

    it 'belongs to a user' do
      employee_slot = FactoryBot.build(:employee_slot)
      expect(employee_slot.user).to be_a(User)
    end
  end

  # describe 'callbacks' do
  #   it 'updates the service_request_item status to employee_assigned after create' do
  #     employee_slot = create(:employee_slot)
  #     expect(employee_slot.service_request_item.status).to eq('employee_assigned')
  #   end

  #   it 'sends an email to the employee after create' do
  #     employee_slot = create(:employee_slot)
  #     expect(SlotMailer).to have_received(:with).with(employee_slot:)
  #     expect(SlotMailer).to have_received(:new_slot)
  #     expect(SlotMailer.deliveries.last.to).to include(employee_slot.user.email)
  #   end
  # end
end
