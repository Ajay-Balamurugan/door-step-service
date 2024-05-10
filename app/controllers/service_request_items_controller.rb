class ServiceRequestItemsController < ApplicationController
  before_action :authenticate_admin, only: %i[show index download]
  before_action :authenticate_customer, only: %i[download]

  def index
    @service_request_items = ServiceRequestItem.where(order_placed: true)
  end

  # refactor the following action
  def show
    @service_request_item = ServiceRequestItem.find(params[:id])
    option = find_option(@service_request_item.option_id)
    employees = Employee.where(service: option.service)
    @available_employees = employees.select do |employee|
      !EmployeeSlot.exists?(employee_id: employee.id, time_slot: @service_request_item.time_slot) &&
        !EmployeeSlot.exists?(employee_id: employee.id,
                              time_slot: (@service_request_item.time_slot - option.duration.hours..@service_request_item.time_slot + option.duration.hours))
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
      else
        redirect_to service_request_path(@service_request_item.service_request),
                    notice: 'Feedback Succesfully submitted'
      end
    else
      render json: { message: 'Error! Unable to Update Service' }, status: :unprocessable_entity
    end
  end

  def download
    @pdf_service_request_items = ServiceRequestItem.where(time_slot: params[:from_date]..params[:to_date])
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'service_history',
               template: 'service_request_items/download',
               layout: 'pdf',
               locals: { service_request_items: @pdf_service_request_items }
      end
    end
  end

  private

  def authenticate_admin
    redirect_to root_path, alert: 'You are not authorized to visit the page' unless current_user&.user_is_admin?
  end

  def authenticate_customer
    redirect_to root_path, alert: 'You are not authorized to Perform this action' unless current_user&.user_is_customer?
  end

  def service_request_item_params
    params.require(:service_request_item).permit(:status, :feedback, before_service_images: [],
                                                                     after_service_images: [])
  end
end
