class EmployeesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_admin, only: %i[new create]
  before_action :authenticate_employee, only: %i[index edit update]

  def index
    @employee_slots = current_user.employee.employee_slots
  end

  def new
    @user = User.new
    @role_id = EMPLOYEE_ROLE_ID
  end

  def create
    @user = User.new(employee_params)
    @employee.user.role = :employee
    if @employee.save
      redirect_to admin_dashboard_path, notice: 'Successfully Created Employee'
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(employee_params)
      redirect_to employee_dashboard_path, notice: 'Employee was successfully updated.'
    else
      render :edit
    end
  end

  def verify_otp
    service_request_item = ServiceRequestItem.find(params[:service_request_item_id])
    if service_request_item.authenticate_otp(params[:otp])
      service_request_item.status = 'in_progress'
      service_request_item.save
      redirect_to edit_service_request_item_path(service_request_item)
    else
      flash[:alert] = 'Incorrect OTP. Please try again.'
      redirect_to employee_dashboard_path
    end
  end

  def send_otp
    service_request_item = ServiceRequestItem.find(params[:service_request_item_id])
    twilio_client = TwilioClient.new
    customer_phone = "+91#{service_request_item.service_request.customer.phone_number}"
    twilio_client.send_text(customer_phone,
                            "Your OTP is #{service_request_item.otp_code}. Please share this with the service agent to avail the service.")
  end

  private

  def employee_params
    params.require(:user).permit(%i[id name email password password_confirmation role_id service_id])
  end

  def authenticate_employee
    redirect_to root_path alert: 'You are not allowed to visit that page' unless user_is_employee?
  end

  def authenticate_admin
    redirect_to root_path alert: 'You are not allowed to visit that page' unless user_is_admin?
  end
end
