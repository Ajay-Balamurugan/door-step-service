class CartsController < ApplicationController
  before_action :authenticate_customer

  def show
    @service_request_items = current_customer.service_request_items.where(order_placed: false)
  end

  private

  def authenticate_customer
    return if current_customer&.cart&.id == params[:id].to_i

    redirect_to root_path, alert: 'You are not authorized to visit this page'
  end
end
