class CartItemsController < ApplicationController
  before_action :set_cart

  def create
    product = Product.find(params[:product_id])
    @cart_item = @cart.cart_items.find_by(product: product)

    if @cart_item
      @cart_item.increment!(:quantity)
    else
      @cart.cart_items.create(product: product, quantity: 1)
    end

    redirect_to cart_path(@cart), notice: 'Product added to cart.'
  end

  def destroy
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path(@cart), notice: 'Product removed from cart.'
  end

  def update
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.update(quantity: params[:quantity])
    redirect_to cart_path(@cart), notice: 'Cart updated.'
  end

  private

  def set_cart
    @cart = current_user ? current_user.cart : Cart.find(session[:cart_id])
  end
end
