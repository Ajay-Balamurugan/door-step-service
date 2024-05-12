module Services
  module CartService
    class CartTotalCalculator
      def initialize(cart_items)
        @cart_items = cart_items
      end

      def calculate_total
        total = 0
        @cart_items.each do |cart_item|
          total += cart_item.option.price
        end
        total
      end
    end
  end
end
