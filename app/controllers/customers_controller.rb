class CustomersController < ApplicationController
  def index
    @services = Service.all
  end

  def customer_show
    @service = Service.find(params[:id])
  end
end
