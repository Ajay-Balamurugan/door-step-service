class AdminsController < ApplicationController
  before_action :authenticate_admin

  def index
    @service_request_items = ServiceRequestItem.where(status: :order_placed)
    @options = Option.with_deleted
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

  def authenticate_admin
    redirect_to root_path, alert: 'You are not authorised to access this content' unless current_user&.admin?
  end
end
