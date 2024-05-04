class CartsController < ApplicationController
  before_action :authenticate_customer

  def show
    @cart = current_customer.cart
  end

  private

  def authenticate_customer
    return if current_customer&.cart&.id == params[:id].to_i

    redirect_to root_path, alert: 'You are not authorized to visit this page'
  end
end
