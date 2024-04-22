class EmployeesController < ApplicationController
   def home
   
   end
   
   def new
      @employee = Employee.new
   end

   def create
      @employee = Employee.new(employee_params)
      if @employee.save
      redirect_to root_path, notice: "Logged in as employee"
      else
      render :new
      end
   end

   private

   def employee_params
      params.require(:employee).permit(:skill, user_attributes: [:email, :password, :password_confirmation])
   end
end
   