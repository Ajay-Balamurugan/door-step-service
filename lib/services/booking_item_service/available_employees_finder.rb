module Services
  module BookingItemService
    class AvailableEmployeesFinder
      def initialize(service_request_item, option)
        @service_request_item = service_request_item
        @option = option
      end

      def find_available_employees
        employees = User.where(service: @option.service)
        @available_employees = employees.select do |employee|
          !EmployeeSlot.exists?(user_id: employee.id, time_slot: @service_request_item.time_slot) &&
            !EmployeeSlot.exists?(user_id: employee.id,
                                  time_slot: (@service_request_item.time_slot - @option.duration.hours..@service_request_item.time_slot + @option.duration.hours))
        end
      end
    end
  end
end
