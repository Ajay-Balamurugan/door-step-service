module Services
  module BookingItemService
    class AvailableEmployeesFinder
      def initialize(service_request_item, option)
        @service_request_item = service_request_item
        @option = option
      end

      def find_available_employees
        employees = User.where(service: Service.with_deleted.find(@option.service_id))
        time_slot_start = @service_request_item.time_slot - @option.duration.hours
        time_slot_end = @service_request_item.time_slot + @option.duration.hours

        @available_employees = employees.select do |employee|
          available?(employee, time_slot_start.to_time, time_slot_end.to_time)
        end
      end

      def available?(employee, start_time, end_time)
        slots = EmployeeSlot.where(user: employee)
        slots.each do |slot|
          booked_start_time = slot.time_slot.to_time
          booked_end_time = slot.time_slot.to_time + slot.service_request_item.option.duration.hours
          return false if (start_time...end_time).overlaps?(booked_start_time...booked_end_time)
        end
        true
      end
    end
  end
end
