class ServiceRequestItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_service_request_item, only: %i[show edit update destroy download_invoice]
  before_action :authenticate_admin, only: %i[show download_history index]
  before_action :authenticate_customer, only: %i[create destroy download_invoice]

  def create
    @service_request_item = current_user.service_request_items.new(service_request_item_params)

    if @service_request_item.save
      render json: { message: 'Item added to cart', cart_count: updated_cart_count }, status: :created
    else
      render json: { message: 'Unable to Add Item to Cart.', errors: @service_request_item.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def index
    @service_request_items = ServiceRequestItem.paginate(page: params[:page], per_page: 8).where(order_placed: true)
  end

  def show
    option = find_option(@service_request_item.option_id)
    @available_employees = available_employees_finder_class.new(@service_request_item, option).find_available_employees
  end

  def edit
  end

  def update
    if @service_request_item.update(service_request_item_params)
      redirect_path = determine_redirect_path
      redirect_to redirect_path, notice: 'Successfully updated Service request status'
    else
      render json: { message: 'Error Unable to Update Service' }, status: :unprocessable_entity
    end
  end

  def destroy
    removed_option_price = find_option(@service_request_item.option_id).price
    if @service_request_item.destroy
      render json: { message: 'Succesfully Removed Item From Cart', removed_item_price: removed_option_price, cart_count: updated_cart_count },
             status: :ok
    else
      render json: { message: 'Error! Unable to remove Item from Cart' }, status: :unprocessable_entity
    end
  end

  # Download Service History PDF as Admin
  def download_history
    @service_request_items = ServiceRequestItem.where(time_slot: params[:from_date]..params[:to_date])
    respond_to do |format|
      format.pdf do
        render pdf: 'service_history',
               template: 'service_request_items/history',
               layout: 'pdf',
               locals: { service_request_items: @service_request_items }
      end
    end
  end
  # Download Invoice PDF as customer
  def download_invoice
    respond_to do |format|
      format.pdf do
        render pdf: 'service_invoice',
               template: 'service_request_items/invoice',
               layout: 'pdf',
               locals: { item: @service_request_item }
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

  def available_employees_finder_class
    Services::BookingItemService::AvailableEmployeesFinder
  end

  def set_service_request_item
    @service_request_item = ServiceRequestItem.find(params[:id])
  end

  def determine_redirect_path
    if user_is_admin?
      admin_dashboard_path
    elsif user_is_employee?
      employee_dashboard_path
    elsif user_is_customer?
      service_request_path(@service_request_item.service_request)
    else
      root_path
    end
  end
end
