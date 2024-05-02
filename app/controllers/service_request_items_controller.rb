class ServiceRequestItemsController < ApplicationController
  # refactor the following action
  def show
    @service_request_item = ServiceRequestItem.find(params[:id])
    employees = Employee.where(service: @service_request_item.option.service)
    @available_employees = employees.select do |employee|
      !EmployeeSlot.exists?(employee_id: employee.id, time_slot: @service_request_item.time_slot) &&
        !EmployeeSlot.exists?(employee_id: employee.id,
                              time_slot: (@service_request_item.time_slot - 2.hours..@service_request_item.time_slot + 2.hours))
    end
  end
end
