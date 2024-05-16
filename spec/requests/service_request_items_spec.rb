# spec/requests/service_request_items_controller_spec.rb
require 'rails_helper'

RSpec.describe 'ServiceRequestItems', type: :request do
  let(:admin) { create(:user, :admin) }
  let(:customer) { create(:user, :customer) }
  let(:service_request_item) { create(:service_request_item, user: customer) }

  describe 'POST #create' do
    context 'when authenticated as customer' do
      before { sign_in customer }

      it 'creates a new service request item' do
        option = create(:option)
        service_request_item_params = {
          service_request_item: {
            option_id: option.id,
            time_slot: 'Wed, 22 May 2024 10:55:00.000000000 UTC +00:00',
            user_id: customer.id,
            status: 'order_placed'
          }
        }

        expect do
          post service_request_items_path, params: service_request_item_params
        end.to change(ServiceRequestItem, :count).by(1)

        expect(response).to have_http_status(:created)
      end

      it 'returns an error message when invalid params are provided' do
        service_request_item_params = {
          service_request_item: {
            option_id: nil,
            time_slot: 'Wed, 10 May 2024 10:55:00.000000000 UTC +00:00'
          }
        }

        post service_request_items_path, params: service_request_item_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when not authenticated as customer' do
      it 'redirects to root path' do
        option = create(:option)
        service_request_item_params = {
          service_request_item: {
            option_id: option.id,
            time_slot: 'Wed, 22 May 2024 10:55:00.000000000 UTC +00:00',
            user_id: customer.id,
            status: 'order_placed'
          }
        }

        post service_request_items_path, params: service_request_item_params
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #index' do
    context 'when authenticated as admin' do
      before { sign_in admin }

      it 'returns a successful response' do
        get service_request_items_path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when not authenticated as admin' do
      it 'redirects to root path' do
        get service_request_items_path
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #show' do
    context 'when authenticated as admin' do
      before { sign_in admin }

      it 'returns a successful response' do
        get service_request_item_path(service_request_item)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when not authenticated as admin' do
      it 'redirects to root path' do
        get service_request_item_path(service_request_item)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PATCH #update' do
    context 'when authenticated as customer' do
      before { sign_in customer }

      it 'updates the service request item' do
        new_feedback = 'Good'
        patch service_request_item_path(service_request_item), params: {
          service_request_item: { feedback: new_feedback }
        }
        service_request_item.reload
        expect(service_request_item.feedback).to eq(new_feedback)
      end
    end

    context 'when authenticated as admin' do
      before { sign_in admin }

      it 'updates the service request item status' do
        patch service_request_item_path(service_request_item), params: {
          service_request_item: { status: 'rejected' }
        }

        service_request_item.reload
        expect(service_request_item.status).to eq('rejected')
      end
    end

    context 'when not authenticated' do
      it 'redirects to root path' do
        patch service_request_item_path(service_request_item), params: {
          service_request_item: { feedback: 'Updated feedback' }
        }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when authenticated as customer' do
      before { sign_in customer }

      it 'destroys the service request item' do
        service_request_item = create(:service_request_item, user: customer, order_placed: false)

        expect do
          delete service_request_item_path(service_request_item)
        end.to change(ServiceRequestItem, :count).by(-1)

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when not authenticated as customer' do
      it 'redirects to root path' do
        service_request_item = create(:service_request_item, user: customer, order_placed: false)
        delete service_request_item_path(service_request_item)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
