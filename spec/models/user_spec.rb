require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid without an email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid without a password' do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
    end

    context 'when user is a customer' do
      it 'is not valid with an invalid phone number' do
        user = build(:user, role: create(:role, :customer), phone_number: '123456789')
        expect(user).not_to be_valid
      end
    end
  end

  describe 'associations' do
    it 'belongs to a role' do
      user = create(:user)
      expect(user.role).to be_a(Role)
    end

    # it 'has many service requests' do
    #   user = create(:user)
    #   service_request1 = create(:service_request, user:)
    #   service_request2 = create(:service_request, user:)
    #   expect(user.service_requests).to include(service_request1, service_request2)
    # end

    context 'when user is an employee' do
      it 'belongs to a service' do
        employee = create(:user, :employee)
        expect(employee.service).to be_a(Service)
      end

      # it 'has many employee slots' do
      #   employee = create(:user, :employee)
      #   employee_slot1 = create(:employee_slot, user: employee)
      #   employee_slot2 = create(:employee_slot, user: employee)
      #   expect(employee.employee_slots).to include(employee_slot1, employee_slot2)
      # end
    end
  end
end
