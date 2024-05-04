class EmployeesController < ApplicationController
  before_action :authenticate_admin, only: %i[new create]
  before_action :authenticate_employee, only: %i[index]

  def index
    @employee_slots = current_user.employee.employee_slots
  end

  def new
    @employee = Employee.new
    @employee.build_user
  end

  def create
    @employee = Employee.new(employee_params)
    @employee.user.role = :employee
    if @employee.save
      redirect_to admin_dashboard_path, notice: 'Successfully Created Employee'
    else
      render :new
    end
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.update(employee_params)
      redirect_to employee_dashboard_path, notice: 'Employee was successfully updated.'
    else
      render :edit
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:service_id, user_attributes: %i[id name email password password_confirmation])
  end

  def authenticate_employee
    redirect_to root_path alert: 'You are not allowed to visit that page' unless current_user&.employee?
  end

  def authenticate_admin
    redirect_to root_path alert: 'You are not allowed to visit that page' unless current_user&.admin?
  end
end
