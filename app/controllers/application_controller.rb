class ApplicationController < ActionController::Base
  helper_method :find_option, :find_service, :user_is_customer?, :user_is_admin?, :user_is_employee?

  def user_is_customer?
    current_user.role.name == 'customer' if current_user
  end

  def user_is_admin?
    current_user.role.name == 'admin' if current_user
  end

  def user_is_employee?
    current_user.role.name == 'employee' if current_user
  end

  def authenticate_admin
    redirect_to root_path, alert: 'You are not authorized to visit the page' unless user_is_admin?
  end

  def authenticate_employee
    redirect_to root_path, alert: 'You are not allowed to visit that page' unless user_is_employee?
  end

  def authenticate_customer
    redirect_to root_path, alert: 'You are not authorized to Perform this action' unless user_is_customer?
  end

  # find option from all options (including soft deleted options)
  def find_option(id)
    Option.with_deleted.find(id)
  end

  # find service from all services (including soft deleted services)
  def find_service(id)
    Service.with_deleted.find(id)
  end

  # calculate total cart amount for customer
  def calculate_cart_total
    cart_items = ServiceRequestItem.where(user: current_user, order_placed: false)
    Services::CartService::CartTotalCalculator.new(cart_items).calculate_total
  end

  private

  # Overriding Devise in built method
  def after_sign_in_path_for(user)
    if user_is_admin?
      admin_dashboard_path
    elsif user_is_employee?
      employee_dashboard_path
    else
      root_path
    end
  end
end
