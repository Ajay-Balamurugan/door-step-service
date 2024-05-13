require 'rails_helper'

RSpec.describe 'Services', type: :request do
  let(:admin) { create(:user, :admin) }

  let(:valid_attributes) do
    { title: 'Haircut', description: 'Get a fresh haircut' }
  end
  let(:invalid_attributes) { { title: nil } }

  describe 'GET /services' do
    before do
      sign_in admin
    end
    it 'returns a successful response' do
      get services_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /services/:id' do
    let(:service) { create(:service) }

    it 'returns a successful response' do
      get service_path(service)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /services' do
    context 'when authenticated as admin' do
      before { sign_in admin }

      context 'with valid parameters' do
        it 'creates a new Service' do
          expect do
            post services_path, params: { service: valid_attributes }
          end.to change(Service, :count).by(1)
        end

        it 'renders the service partial' do
          post services_path, params: { service: valid_attributes }
          expect(response).to render_template(partial: '_service')
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new Service' do
          expect do
            post services_path, params: { service: invalid_attributes }
          end.to change(Service, :count).by(0)
        end

        it 'returns an unprocessable entity response' do
          post services_path, params: { service: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'when not authenticated as admin' do
      it 'redirects to root path' do
        post services_path, params: { service: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PATCH /services/:id' do
    let(:service) { create(:service) }

    context 'when authenticated as admin' do
      before { sign_in admin }

      context 'with valid parameters' do
        let(:new_attributes) { { title: 'New Title' } }

        it 'updates the requested service' do
          patch service_path(service), params: { service: new_attributes }
          service.reload
          expect(service.title).to eq('New Title')
        end

        it 'renders the service partial' do
          patch service_path(service), params: { service: new_attributes }
          expect(response).to render_template(partial: '_service')
        end
      end

      context 'with invalid parameters' do
        it 'returns an unprocessable entity response' do
          patch service_path(service), params: { service: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'when not authenticated as admin' do
      it 'redirects to root path' do
        patch service_path(service), params: { service: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'DELETE /services/:id' do
    let!(:service) { create(:service) }

    context 'when authenticated as admin' do
      before { sign_in admin }

      it 'destroys the requested service' do
        expect do
          delete service_path(service)
        end.to change(Service, :count).by(-1)
      end

      it 'returns a success response' do
        delete service_path(service)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when not authenticated as admin' do
      it 'redirects to root path' do
        delete service_path(service)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
