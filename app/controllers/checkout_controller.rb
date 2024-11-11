class CheckoutController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:show, :comment_create]  # Define @cart before both actions

  def show
    @total = @cart.cart_items.sum { |item| item.product.price * item.quantity }
    @delivery_methods = ["Standard Shipping", "Express Shipping"]
  end

  def create
    delivery_method = params[:delivery_method]
    amount = (@cart.cart_items.sum { |item| item.product.price * item.quantity } * 100).to_i

    Stripe::Charge.create({
                            amount: amount,
                            currency: 'usd',
                            source: params[:stripeToken],
                            description: "Order for #{current_user.email}",
                          })

    # Update stock for each purchased product
    @cart.cart_items.each do |item|
      product = item.product
      product.update(stock: product.stock - item.quantity)
    end


    @cart.cart_items.destroy_all
    redirect_to root_path, notice: "Payment successful! Your order will be shipped via #{delivery_method}."
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    render :show
  end

  private

  def set_cart
    @cart = current_user.cart
  end
end
