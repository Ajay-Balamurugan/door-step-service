class ServiceRequestItemsController < ApplicationController
  before_action :authenticate_admin_or_employee

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

  def edit
    @service_request_item = ServiceRequestItem.find(params[:id])
  end

  def update
    @service_request_item = ServiceRequestItem.find(params[:id])
    if @service_request_item.update(service_request_item_params)
      if current_user&.admin?
        redirect_to admin_dashboard_path, notice: 'Service request was successfully rejected.'
      elsif current_user&.employee?
        redirect_to employee_dashboard_path, notice: 'Service request was successfully completed'
      end
    else
      render json: { message: 'Error! Unable to Update Service' }, status: :unprocessable_entity
    end
  end

  private

  def authenticate_admin_or_employee
    return if current_user&.admin? || current_user&.employee?

    redirect_to root_path, alert: 'You are not authorized to visit the page'
  end

  def service_request_item_params
    params.require(:service_request_item).permit(:status, before_service_images: [], after_service_images: [])
  end
end
