class ServiceRequestsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_customer

  def create
    @service_request = ServiceRequest.new(customer_id: current_customer.id, total: current_customer.cart.total)
    if @service_request.save
      render partial: 'booking_success', status: :created
    else
      redirect_to cart_path, notice: 'Unable to place Order.'
    end
  end

  def index
    @service_requests = current_customer.service_requests
  end

  def show
    @service_request_items = ServiceRequest.find(params[:id]).service_request_items
    @options = Option.with_deleted
  end

  def authenticate_customer
    redirect_to root_path, alert: 'You are not authorized to visit the page' unless current_user&.customer?
  end
end
