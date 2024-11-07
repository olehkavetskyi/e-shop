class PaymentsController < ApplicationController
  def new
    @product = Product.find(params[:product_id]) # Assuming a product purchase
    @stripe_publishable_key = Rails.application.credentials.dig(:stripe, :publishable_key)
  end

  def create
    @product = Product.find(params[:product_id])
    Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)

    # Create a payment intent
    payment_intent = Stripe::PaymentIntent.create(
      amount: (@product.price * 100).to_i, # Stripe expects amount in cents
      currency: 'usd',
      payment_method_types: ['card']
    )

    render json: { client_secret: payment_intent['client_secret'] }
  rescue Stripe::StripeError => e
    render json: { error: e.message }, status: 500
  end
end
