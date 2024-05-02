module Services
  module EmployeeSlotHelper
    class AvailableEmployeesCreator
      def initialize(service_request_items)
        @items = service_request_items
        @employees = Employee.all
      end

      def call
        available_employees = {}
        @items.each do |item|
          service = item.option.service
          slot = item.time_slot
          @employees.find_by(skill: 'service')
        end
      end
    end
  end
end
