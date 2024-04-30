class CartItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_cart

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.cart = current_customer.cart
    if @cart_item.save
      # render partial: 'cart_item', locals: { cart_item: @cart_item }, status: :created
      current_customer.cart.total += @cart_item.option.price
      @cart.save
      redirect_to cart_path(current_customer.cart), notice: "Service Added to cart Successfully"
    else
      render json: { message: 'Unable to Add Item to Cart.' }, status: :unprocessable_entity
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_path(current_customer.cart), notice: "Successfully updated time slot"
      # render partial: 'cart_item', locals: { cart_item: @cart_item }, status: :ok
    else
      render json: { message: 'Error! Unable to Update Item' }, status: :unprocessable_entity
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    if @cart_item.destroy
      @cart.total -= @cart_item.option.price
      @cart.save
      # redirect_to cart_path(current_customer.cart), notice: "Removed item from cart Successfully"
      render json: { message: 'Succesfully Removed Item From Cart', total: @cart.total }, status: :ok
    else
      render json: { message: 'Error! Unable to remove Item from Cart' }, status: :unprocessable_entity
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:option_id, :time_slot)
  end

  def set_cart
    @cart = current_customer.cart
  end
end
