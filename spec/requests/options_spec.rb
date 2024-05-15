require 'rails_helper'

RSpec.describe 'Options', type: :request do
  let(:admin) { FactoryBot.create(:user, :admin) }
  let(:service) { FactoryBot.create(:service) }

  describe 'POST #create' do
    let(:valid_attributes) { attributes_for(:option, service_id: service.id) }
    let(:invalid_attributes) { attributes_for(:option, title: nil, service_id: service.id) }

    context 'when authenticated as admin' do
      before { sign_in admin }

      context 'with valid parameters' do
        it 'creates a new Option' do
          expect do
            post service_options_path(service_id: service.id), params: { option: valid_attributes }
          end.to change(Option, :count).by(1)
        end

        it 'renders the option partial' do
          post service_options_path(service_id: service.id), params: { option: valid_attributes }
          expect(response).to render_template(partial: '_option')
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new Option' do
          expect do
            post service_options_path(service_id: service.id), params: { option: invalid_attributes }
          end.to change(Option, :count).by(0)
        end

        it 'returns an unprocessable entity response' do
          post service_options_path(service_id: service.id), params: { option: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'when not authenticated as admin' do
      it 'redirects to root path' do
        post service_options_path(service_id: service.id), params: { option: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PATCH #update' do
    let(:option) { FactoryBot.create(:option, service:) }
    let(:valid_attributes) { { title: 'Updated Option Title' } }
    let(:invalid_attributes) { { title: nil } }

    context 'when authenticated as admin' do
      before { sign_in admin }

      context 'with valid parameters' do
        it 'updates the requested option' do
          patch service_option_path(service_id: service.id, id: option.id), params: { option: valid_attributes }
          option.reload
          expect(option.title).to eq('Updated Option Title')
        end

        it 'renders the option partial' do
          patch service_option_path(service_id: service.id, id: option.id), params: { option: valid_attributes }
          expect(response).to render_template(partial: '_option')
        end
      end

      context 'with invalid parameters' do
        it 'returns an unprocessable entity response' do
          patch service_option_path(service_id: service.id, id: option.id), params: { option: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:option) { FactoryBot.create(:option, service:) }

    context 'when authenticated as admin' do
      before { sign_in admin }

      it 'destroys the requested option' do
        expect do
          delete service_option_path(service_id: service.id, id: option.id)
        end.to change(Option, :count).by(-1)
      end

      it 'returns a success response' do
        delete service_option_path(service_id: service.id, id: option.id)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when not authenticated as admin' do
      it 'redirects to root path' do
        delete service_option_path(service_id: service.id, id: option.id)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
