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

    redirect_to cart_path, notice: 'Product added to cart.'
  end

  def destroy
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path, notice: 'Product removed from cart.'
  end

  def update
    @cart_item = @cart.cart_items.find(params[:id])

    # Update quantity only if it's greater than 0
    new_quantity = params[:quantity].to_i
    if new_quantity > 0
      @cart_item.update(quantity: new_quantity)
      redirect_to cart_path, notice: 'Cart updated.'
    else
      @cart_item.destroy
      redirect_to cart_path, notice: 'Item removed from cart.'
    end
  end

  private

  def set_cart
    @cart = current_user ? current_user.cart : Cart.find(session[:cart_id])
  end
end
