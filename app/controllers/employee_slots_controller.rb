class EmployeeSlotsController < ApplicationController
  before_action :authenticate_admin, only: %i[create]

  def create
    @employee_slot = EmployeeSlot.new(employee_slot_params)
    if @employee_slot.save
      @employee_slot.service_request_item.status = 'employee_assigned'
      @employee_slot.service_request_item.save
      redirect_to admin_dashboard_path, notice: 'Employee Assigned Successfully'
    else
      render json: { message: 'Unable to Create Service.' }, status: :unprocessable_entity
    end
  end

  private

  def employee_slot_params
    params.require(:employee_slot).permit(:employee_id, :service_request_item_id, :time_slot)
  end

  def authenticate_admin
    redirect_to root_path, alert: 'You are not authorized to visit the page' unless current_user&.admin?
  end
end
