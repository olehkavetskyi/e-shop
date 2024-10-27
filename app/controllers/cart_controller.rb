class CartsController < ApplicationController
  before_action :authenticate_user!  # Ensure only logged-in users can access the cart

  def show
    @cart = current_user.cart
  end

  def add_to_cart
    @cart = current_user.cart || current_user.create_cart
    @product = Product.find(params[:product_id])
    cart_item = @cart.cart_items.find_or_initialize_by(product: @product)
    cart_item.quantity = (cart_item.quantity || 0) + 1
    cart_item.save
    redirect_to cart_path, notice: 'Product added to cart.'
  end

  def remove_from_cart
    @cart = current_user.cart
    cart_item = @cart.cart_items.find_by(product_id: params[:product_id])
    cart_item.destroy if cart_item
    redirect_to cart_path, notice: 'Product removed from cart.'
  end
end
