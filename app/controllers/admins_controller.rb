class AdminsController < ApplicationController
  def index
    @service_request_items = ServiceRequestItem.all
  end

  def new
    @admin = Admin.new
    @admin.build_user
  end

  def create
    @admin = Admin.new(admin_params)
    @admin.user.role = :admin
    if @admin.save
      redirect_to admin_dashboard_path, notice: 'Successfully Created Admin'
    else
      render :new
    end
  end

  private

  def admin_params
    params.require(:admin).permit(user_attributes: %i[name email password password_confirmation])
  end
end
