class RatingsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @rating = @product.ratings.new(rating_params)
    @rating.user = current_user

    if @rating.save
      @product.update_rating!
      redirect_to @product, notice: 'Rating submitted!'
    else
      redirect_to @product, alert: 'Failed to submit rating.'
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:value)
  end
end
