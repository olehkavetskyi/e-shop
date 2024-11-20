class RatingsController < ApplicationController
  before_action :authenticate_user!

  def create
    # Find the product based on the category and id
    @category = Category.find_by!(name: params[:category])
    @product = @category.products.find(params[:id])

    # Initialize the rating for the product
    @rating = @product.ratings.new(rating_params)
    @rating.user = current_user

    if @rating.save
      # Recalculate the product's average rating
      @product.update_rating!
      redirect_to product_path(@category, @product), notice: 'Rating submitted successfully!'
    else
      # Provide detailed feedback on the failure
      redirect_to product_path(@category, @product), alert: @rating.errors.full_messages.to_sentence
    end
  end

  private

  # Strong parameter method for rating
  def rating_params
    params.require(:rating).permit(:value)
  end
end
