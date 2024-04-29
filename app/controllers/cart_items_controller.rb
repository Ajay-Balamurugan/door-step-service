class CartItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_cart

  def new
    @cart_item = CartItem.new
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    if @cart_item.save
      render partial: 'cart_item', locals: { cart_item: @cart_item }, status: :created
    else
      render json: { message: 'Unable to Add Item to Cart.' }, status: :unprocessable_entity
    end
  end

  def edit
    @cart_item = CartItem.find(params[:id])
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      render partial: 'cart_item', locals: { cart_item: @cart_item }, status: :ok
    else
      render json: { message: 'Error! Unable to Update Item' }, status: :unprocessable_entity
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    if @cart_item.destroy
      render json: { message: 'Succesfully Removed Item From Cart' }, status: :ok
    else
      render json: { message: 'Error! Unable to remove Item from Cart' }, status: :unprocessable_entity
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:time_slot, :option_id)
  end

  def set_cart
    @cart = current_customer.cart
  end
end
