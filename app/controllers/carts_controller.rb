class CartsController < ApplicationController
  before_action :authenticate_customer

  def show
    @service_request_items = current_user.service_request_items.where(order_placed: false)
    @cart_total = calculate_cart_total
  end
end
