class AdminsController < ApplicationController
  before_action :authenticate_admin

  def home
    @service_request_items = ServiceRequestItem.where(status: :order_placed)
    @options = Option.with_deleted
  end

  def new
    @user = User.new
    @role_id = ADMIN_ROLE_ID
  end

  def create
    @user = User.new(admin_params)
    if @user.save
      redirect_to admin_dashboard_path, notice: 'Successfully Created Admin'
    else
      render :new
    end
  end

  private

  def admin_params
    params.require(:user).permit(%i[name email password password_confirmation role_id])
  end
end
