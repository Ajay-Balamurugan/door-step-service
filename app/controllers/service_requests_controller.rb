class ServiceRequestsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_customer

  def create
    service_request = ServiceRequest.new(user: current_user, total: calculate_cart_total)
    if service_request.save
      Services::BookingService::BookingCreator.new(current_user.id, service_request).create_booking
      render partial: 'booking_success', status: :created
    else
      redirect_to cart_path, notice: 'Unable to place Order.'
    end
  end

  def index
    @service_requests = current_user.service_requests
  end

  def show
    @service_request_items = ServiceRequest.find(params[:id]).service_request_items
    @options = Option.with_deleted
  end
end
