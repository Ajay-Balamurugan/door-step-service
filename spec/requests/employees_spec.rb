require 'rails_helper'

RSpec.describe 'Employees', type: :request do
  let(:admin) { create(:user, role_id: create(:role, :admin).id) }
  let(:employee) { create(:user, role_id: create(:role, :employee).id) }
  let(:service_request_item) { create(:service_request_item) }

  describe 'GET #home' do
    context 'when authenticated as employee' do
      before do
        sign_in employee
        create(:employee_slot, user: employee, service_request_item:)
      end

      it 'returns a successful response' do
        get employee_dashboard_path
        expect(response).to have_http_status(:ok)
      end

      it 'assigns @employee_slots with incomplete service request items' do
        get employee_dashboard_path
        expect(assigns(:employee_slots)).to eq([employee.employee_slots.first])
      end
    end

    context 'when not authenticated as employee' do
      it 'redirects to root path' do
        get employee_dashboard_path
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #new' do
    context 'when authenticated as admin' do
      before { sign_in admin }

      it 'returns a successful response' do
        get new_employee_path
        expect(response).to have_http_status(:ok)
      end

      it 'assigns a new User to @user' do
        get new_employee_path
        expect(assigns(:user)).to be_a_new(User)
      end
    end

    context 'when not authenticated as admin' do
      it 'redirects to root path' do
        get new_employee_path
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { attributes_for(:user, :employee) }
    let(:invalid_attributes) { attributes_for(:user, :employee, name: nil) }

    context 'when authenticated as admin' do
      before { sign_in admin }

      context 'with valid parameters' do
        it 'creates a new employee' do
          expect do
            post employees_path, params: { user: valid_attributes }
          end.to change(User, :count).by(1)
        end

        it 'redirects to admin_dashboard_path' do
          post employees_path, params: { user: valid_attributes }
          expect(response).to redirect_to(admin_dashboard_path)
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new employee' do
          expect do
            post employees_path, params: { user: invalid_attributes }
          end.to change(User, :count).by(0)
        end

        it 'renders the new template' do
          post employees_path, params: { user: invalid_attributes }
          expect(response).to render_template(:new)
        end
      end
    end

    context 'when not authenticated as admin' do
      it 'redirects to root path' do
        post employees_path, params: { user: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
