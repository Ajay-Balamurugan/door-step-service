class ServiceRequestItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_admin, only: %i[show download index]
  before_action :authenticate_customer, only: %i[create destroy]

  AVAILABLE_EMPLOYEES_FINDER_CLASS = Services::BookingItemService::AvailableEmployeesFinder

  def create
    @service_request_item = ServiceRequestItem.new(service_request_item_params)
    @service_request_item.user = current_user
    if @service_request_item.save
      render json: { message: 'Item added to cart', cart_count: updated_cart_count }, status: :created
    else
      render json: { message: 'Unable to Add Item to Cart.', errors: @service_request_item.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def index
    @service_request_items = ServiceRequestItem.where(order_placed: true)
  end

  def show
    @service_request_item = ServiceRequestItem.find(params[:id])
    option = find_option(@service_request_item.option_id)
    @available_employees = AVAILABLE_EMPLOYEES_FINDER_CLASS.new(@service_request_item, option).find_available_employees
  end

  def edit
    @service_request_item = ServiceRequestItem.find(params[:id])
  end

  def update
    @service_request_item = ServiceRequestItem.find(params[:id])
    if @service_request_item.update(service_request_item_params)
      if user_is_admin?
        redirect_to admin_dashboard_path, notice: 'Service request was successfully rejected.'
      elsif user_is_employee?
        redirect_to employee_dashboard_path, notice: 'Service request was successfully completed'
      else
        redirect_to service_request_path(@service_request_item.service_request),
                    notice: 'Feedback Succesfully submitted'
      end
    else
      render json: { message: 'Error! Unable to Update Service' }, status: :unprocessable_entity
    end
  end

  def destroy
    @service_request_item = ServiceRequestItem.find(params[:id])
    removed_option_price = @service_request_item.option.price
    if @service_request_item.destroy
      render json: { message: 'Succesfully Removed Item From Cart', removed_item_price: removed_option_price, cart_count: updated_cart_count },
             status: :ok
    else
      render json: { message: 'Error! Unable to remove Item from Cart' }, status: :unprocessable_entity
    end
  end

  def download
    @pdf_service_request_items = ServiceRequestItem.where(time_slot: params[:from_date]..params[:to_date])
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'service_history',
               template: 'service_request_items/download',
               layout: 'pdf',
               locals: { service_request_items: @pdf_service_request_items }
      end
    end
  end

  private

  def updated_cart_count
    current_user.service_request_items.where(order_placed: false).count
  end

  def service_request_item_params
    params.require(:service_request_item).permit(:option_id, :time_slot, :status, :feedback, :user_id, before_service_images: [],
                                                                                                       after_service_images: [])
  end
end
