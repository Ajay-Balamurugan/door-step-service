class ServiceRequestsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_customer

  def create
    @service_request = ServiceRequest.new(user: current_user, total: calculate_cart_total)
    if @service_request.save
      map_service_request_items(current_user.id, @service_request)
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

  def authenticate_customer
    redirect_to root_path, alert: 'You are not authorized to visit the page' unless user_is_customer?
  end
end
