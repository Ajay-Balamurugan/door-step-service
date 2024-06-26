class EmployeesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_admin, only: %i[new create]
  before_action :authenticate_employee, only: %i[home]

  def home
    @employee_slots = current_user.employee_slots.joins(:service_request_item).where.not(service_request_items: { status: 'completed' })
  end

  def new
    @user = User.new
  end

  def create
    @user = Role.find_by(name: 'employee').users.new(employee_params)
    if @user.save
      redirect_to admin_dashboard_path, notice: 'Successfully Created Employee'
    else
      render :new
    end
  end

  # Authenticate the OTP recieved from customer
  def verify_otp
    service_request_item = ServiceRequestItem.find(params[:service_request_item_id])

    if service_request_item.authenticate_otp(params[:otp])
      service_request_item.update(status: 'in_progress')
      redirect_to edit_service_request_item_path(service_request_item)
    else
      redirect_to employee_dashboard_path, alert: 'Incorrect OTP. Please try again.'
    end
  end

  # Send OTP to customer
  def send_otp
    service_request_item = ServiceRequestItem.find(params[:service_request_item_id])
    Services::OtpService::OtpSender.new(service_request_item).send_otp
  end

  private

  def employee_params
    params.require(:user).permit(%i[id name email password password_confirmation service_id])
  end
end
