require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = FactoryBot.create(:user)
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = FactoryBot.build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid without an email' do
      user = FactoryBot.build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid without a password' do
      user = FactoryBot.build(:user, password: nil)
      expect(user).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a role' do
      user = FactoryBot.build(:user)
      expect(user.role).to be_a(Role)
    end

    it 'has many service requests' do
      user = create(:user)
      service_request1 = create(:service_request, user:)
      service_request2 = create(:service_request, user:)
      expect(user.service_requests).to include(service_request1, service_request2)
    end

    context 'when user is an employee' do
      it 'belongs to a service' do
        employee = FactoryBot.build(:user, :employee)
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
