class CustomersController < ApplicationController
  def index
    @services = Service.all
  end
end
