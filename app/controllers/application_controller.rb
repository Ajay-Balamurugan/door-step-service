class ApplicationController < ActionController::Base
  helper_method :current_customer, :find_option, :user_is_customer?, :user_is_admin?, :user_is_employee?,
                :ADMIN_ROLE_ID, :calculate_cart_total

  ADMIN_ROLE_ID = Role.find_by(name: 'admin').id
  EMPLOYEE_ROLE_ID = Role.find_by(name: 'employee').id
  CUSTOMER_ROLE_ID = Role.find_by(name: 'customer').id

  def user_is_customer?
    current_user.role.name == 'customer' if current_user
  end

  def user_is_admin?
    current_user.role.name == 'admin' if current_user
  end

  def user_is_employee?
    current_user.role.name == 'employee' if current_user
  end

  # find options (included soft deleted options) for Paranoia
  def find_option(id)
    Option.with_deleted.find(id)
  end

  def calculate_cart_total
    total = 0
    cart_items = ServiceRequestItem.where(user: current_user, order_placed: false)
    cart_items.each do |cart_item|
      total += cart_item.option.price
    end
    total
  end

  def map_service_request_items(id, request)
    service_request_items_to_assign = ServiceRequestItem.where(user_id: id, order_placed: false)
    service_request_items_to_assign.update_all(service_request_id: request.id, order_placed: true)
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
