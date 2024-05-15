# spec/requests/carts_spec.rb
require 'rails_helper'

RSpec.describe 'Carts', type: :request do
  let(:customer) { create(:user, :customer) }

  describe 'GET #show' do
    context 'when authenticated as customer' do
      before do
        sign_in customer
        create(:service_request_item, user: customer, order_placed: false)
        create(:service_request_item, user: customer, order_placed: true)
      end

      it 'returns a successful response' do
        get cart_path(id: customer.id)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when not authenticated as customer' do
      it 'redirects to root path' do
        get cart_path(id: customer.id)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
