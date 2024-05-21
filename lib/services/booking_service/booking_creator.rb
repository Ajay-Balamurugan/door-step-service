module Services
  module BookingService
    # Class to map service request items to service request after order is placed
    class BookingCreator
      def initialize(id, request)
        @service_request = request
        @user_id = id
      end

      def create_booking
        service_request_items = ServiceRequestItem.where(user_id: @user_id, order_placed: false)
        service_request_items.update_all(service_request_id: @service_request.id, order_placed: true,
                                         status: 'order_placed')
      end
    end
  end
end
