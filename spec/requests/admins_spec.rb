# spec/requests/admins_spec.rb
require 'rails_helper'

RSpec.describe 'Admins', type: :request do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }

  describe 'GET #new' do
    context 'when authenticated as admin' do
      before { sign_in admin }

      it 'returns a successful response' do
        get new_admin_path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when not authenticated as admin' do
      it 'redirects to root path' do
        get new_admin_path
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { attributes_for(:user, role_id: create(:role, :admin).id) }
    let(:invalid_attributes) { attributes_for(:user, name: nil) }

    context 'when authenticated as admin' do
      before { sign_in admin }

      context 'with valid parameters' do
        it 'creates a new admin' do
          expect do
            post admins_path, params: { user: valid_attributes }
          end.to change(User, :count).by(1)
        end

        it 'redirects to admin_dashboard_path' do
          post admins_path, params: { user: valid_attributes }
          expect(response).to redirect_to(admin_dashboard_path)
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new admin' do
          expect do
            post admins_path, params: { user: invalid_attributes }
          end.to change(User, :count).by(0)
        end

        it 'renders the new template' do
          post admins_path, params: { user: invalid_attributes }
          expect(response).to render_template(:new)
        end
      end
    end

    context 'when not authenticated as admin' do
      it 'redirects to root path' do
        post admins_path, params: { user: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #home' do
    context 'when authenticated as admin' do
      before { sign_in admin }

      it 'returns a successful response' do
        get admin_dashboard_path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when not authenticated as admin' do
      it 'redirects to root path' do
        get admin_dashboard_path
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
