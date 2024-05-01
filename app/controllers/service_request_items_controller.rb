class ServiceRequestItemsController < ApplicationController
  def index
    service_request_ids = ServiceRequest.where(customer_id: current_customer.id).pluck(:id)
    @service_request_items = ServiceRequestItem.where(service_request_id: service_request_ids)
  end
end
