class ServiceRequestItemsController < ApplicationController
  def show
    @service_request_item = ServiceRequestItem.find(params[:id])
    @employees = Employee.all
  end
end
