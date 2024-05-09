class ApplicationController < ActionController::Base
  helper_method :current_customer, :find_option, :user_is_customer?, :user_is_admin?, :user_is_employee?

  def user_is_customer?
    current_user.role.name == 'customer' if current_user
  end

  def user_is_admin?
    current_user.role.name == 'admin' if current_user
  end

  def user_is_employee?
    current_user.role.name == 'employee' if current_user
  end

  # find the customer who is currently logged in
  def current_customer
    return unless current_user&.user_is_customer?

    current_user
  end

  # find options (included soft deleted options) for Paranoia
  def find_option(id)
    Option.with_deleted.find(id)
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
