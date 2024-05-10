class CustomersController < ApplicationController
  def index
    @services = Service.all
  end

  # not needed
  def show
    @service = Service.find(params[:id])
    @cart_item = CartItem.new
  end
end
