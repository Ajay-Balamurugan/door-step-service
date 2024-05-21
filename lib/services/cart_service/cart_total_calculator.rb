module Services
  module CartService
    # Class to calculate cart total
    class CartTotalCalculator
      def initialize(cart_items)
        @cart_items = cart_items
      end

      def calculate_total
        total = 0
        @cart_items.each do |cart_item|
          total += Option.with_deleted.find(cart_item.option_id).price
        end
        total
      end
    end
  end
end
