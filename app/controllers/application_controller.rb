class ApplicationController < ActionController::Base

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
