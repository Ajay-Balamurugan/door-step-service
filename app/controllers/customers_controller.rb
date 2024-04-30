class CustomersController < ApplicationController
  def index
    @services = Service.all
  end

  def home
    @service = Service.find(params[:id])
    @cart_item = CartItem.new 
  end
end
