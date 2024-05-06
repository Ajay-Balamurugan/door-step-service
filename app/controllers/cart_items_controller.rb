class CartItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_customer
  before_action :set_cart

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.cart = current_customer.cart
    if @cart_item.save
      @cart.total += @cart_item.option.price
      @cart.save
      render json: { message: 'Item added to cart' }, status: :created
    else
      render json: { message: 'Unable to Add Item to Cart.', errors: @cart_item.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      render json: { date: @cart_item.time_slot }, status: :ok
    else
      render json: { message: 'Error! Unable to Update Item' }, status: :unprocessable_entity
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    if @cart_item.destroy
      @cart.total -= @cart_item.option.price
      @cart.save
      render json: { message: 'Succesfully Removed Item From Cart', total: @cart.total }, status: :ok
    else
      render json: { message: 'Error! Unable to remove Item from Cart' }, status: :unprocessable_entity
    end
  end

  private

  def cart_item_params
    params.permit(:option_id, :time_slot)
  end

  def set_cart
    @cart = current_customer.cart
  end

  def authenticate_customer
    redirect_to root_path, alert: 'You are not authorized to Perform this action' unless current_user&.customer?
  end
end
