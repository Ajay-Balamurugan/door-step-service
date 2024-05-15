require 'rails_helper'

RSpec.describe EmployeeSlotsController, type: :request do
  let(:admin) { create(:user, role_id: create(:role, :admin).id) }
  let(:employee) { create(:user, role_id: create(:role, :employee).id) }
  let(:service_request_item) { create(:service_request_item) }

  describe 'POST #create' do
    context 'when authenticated as admin' do
      before { sign_in admin }

      it 'creates a new employee slot' do
        employee_slot_params = {
          employee_slot: { user_id: employee.id, service_request_item_id: service_request_item.id,
                           time_slot: 'Wed, 22 May 2024 10:55:00.000000000 UTC +00:00' }
        }

        expect do
          post employee_slots_path, params: employee_slot_params
        end.to change(EmployeeSlot, :count).by(1)

        expect(response).to redirect_to(admin_dashboard_path)
      end

      it 'renders an error message when invalid params are provided' do
        employee_slot_params = {
          employee_slot: { user_id: nil, service_request_item_id: service_request_item.id, time_slot: nil }
        }

        post employee_slots_path, params: employee_slot_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when not authenticated as admin' do
      it 'redirects to root path' do
        employee_slot_params = {
          employee_slot: {
            user_id: employee.id,
            service_request_item_id: service_request_item.id,
            time_slot: 'Wed, 22 May 2024 10:55:00.000000000 UTC +00:00'
          }
        }

        post employee_slots_path, params: employee_slot_params

        expect(response).to redirect_to(root_path)
      end
    end
  end
end
