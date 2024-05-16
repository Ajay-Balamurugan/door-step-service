require 'rails_helper'

RSpec.describe Services::CartService::CartTotalCalculator do
  describe '#calculate_total' do
    let(:option1) { create(:option, price: 100) }
    let(:option2) { create(:option, price: 200) }
    let(:option3) { create(:option, price: 300) }

    context 'with cart items' do
      let(:cart_items) do
        [
          create(:service_request_item, option: option1),
          create(:service_request_item, option: option2),
          create(:service_request_item, option: option3)
        ]
      end

      it 'calculates the total price of all cart items' do
        calculator = described_class.new(cart_items)
        total = calculator.calculate_total

        expect(total).to eq(600)
      end
    end

    context 'with no cart items' do
      let(:cart_items) { [] }

      it 'returns 0 as the total' do
        calculator = described_class.new(cart_items)
        total = calculator.calculate_total

        expect(total).to eq(0)
      end
    end

    context 'with deleted options' do
      let(:deleted_option) { create(:option, price: 400, deleted_at: Time.now) }
      let(:cart_items) do
        [
          create(:service_request_item, option: option1),
          create(:service_request_item, option: deleted_option)
        ]
      end

      it 'includes the price of deleted options in the total' do
        calculator = described_class.new(cart_items)
        total = calculator.calculate_total

        expect(total).to eq(500)
      end
    end
  end
end
