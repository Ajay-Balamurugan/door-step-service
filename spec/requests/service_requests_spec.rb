# spec/requests/service_requests_spec.rb
require 'rails_helper'

RSpec.describe 'ServiceRequests', type: :request do
  let(:customer) { create(:user, role_id: create(:role, :customer).id) }

  describe 'POST #create' do
    context 'when authenticated as customer' do
      before do
        sign_in customer
      end

      it 'creates a new service request' do
        expect do
          post service_requests_path
        end.to change(ServiceRequest, :count).by(1)
      end

      it 'returns a successful response' do
        post service_requests_path
        expect(response).to have_http_status(:created)
      end

      it 'sets the total based on the cart items' do
        post service_requests_path
        service_request = ServiceRequest.last
        total = service_request.service_request_items.sum(&:option_price)
        expect(service_request.total).to eq(total)
      end
    end

    context 'when not authenticated as customer' do
      it 'redirects to root path' do
        post service_requests_path
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #index' do
    context 'when authenticated as customer' do
      before do
        sign_in customer
        create_list(:service_request, 3, user: customer)
      end

      it 'returns a successful response' do
        get service_requests_path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when not authenticated as customer' do
      it 'redirects to root path' do
        get service_requests_path
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #show' do
    let(:service_request) { create(:service_request, user: customer) }

    context 'when authenticated as customer' do
      before do
        sign_in customer
      end

      it 'returns a successful response' do
        get service_request_path(service_request)
        expect(response).to have_http_status(:ok)
      end

      it 'assigns @service_request_items with the service request items' do
        get service_request_path(service_request)
        expect(assigns(:service_request_items)).to match_array(service_request.service_request_items)
      end
    end

    context 'when not authenticated as customer' do
      it 'redirects to root path' do
        get service_request_path(service_request)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
