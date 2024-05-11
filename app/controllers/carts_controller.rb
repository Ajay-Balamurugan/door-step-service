class CartsController < ApplicationController
  before_action :authenticate_customer

  def show
    @service_request_items = current_user.service_request_items.where(order_placed: false)
  end

  private

  def authenticate_customer
    redirect_to root_path, alert: 'Error! You are not authorized to visit this page' unless params[:id].to_i == current_user&.id # rubocop:disable Style/IfUnlessModifier
  end
end
