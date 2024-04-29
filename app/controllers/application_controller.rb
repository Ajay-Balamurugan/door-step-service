class ApplicationController < ActionController::Base
  helper_method :current_customer

  # find the customer who is currently logged in
  def current_customer
    return unless current_user&.customer?

    current_user.customer
  end

  private

  # Overriding Devise in built method
  def after_sign_in_path_for(user)
    if user.admin?
      admin_dashboard_path
    elsif user.employee?
      employee_dashboard_path
    else
      root_path
    end
  end
end
