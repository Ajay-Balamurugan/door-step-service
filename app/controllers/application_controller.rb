class ApplicationController < ActionController::Base
  helper_method :current_customer
  helper_method :find_option

  # find the customer who is currently logged in
  def current_customer
    return unless current_user&.customer?

    current_user.customer
  end

  def find_option(id)
    Option.with_deleted.find(id)
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
