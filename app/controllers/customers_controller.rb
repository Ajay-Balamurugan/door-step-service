class CustomersController < ApplicationController
  def home
    @services = Service.all
  end
end
