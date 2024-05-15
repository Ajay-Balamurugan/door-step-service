module NavbarHelper
  def employee_nav_bar
    yield if user_is_employee?
  end

  def admin_nav_bar
    yield if user_is_admin?
  end

  def customer_nav_bar
    yield if !user_is_admin? && !user_is_employee?
  end

  def cart_count
    current_user.service_request_items.where(order_placed: false).count
  end
end
