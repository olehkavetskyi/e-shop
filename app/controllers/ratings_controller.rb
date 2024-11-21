class RatingsController < ApplicationController
  before_action :authenticate_user!

  def create
    # Find the product based on the category and id
    @category = Category.find_by!(name: params[:category])
    @product = @category.products.find(params[:id])

    # Check if the user has already rated this product
    existing_rating = @product.ratings.find_by(user: current_user)

    if existing_rating
      # Update the existing rating
      if existing_rating.update(rating_params)
        @product.update_rating!
        redirect_to product_path(@category, @product), notice: 'Your rating has been updated!'
      else
        redirect_to product_path(@category, @product), alert: existing_rating.errors.full_messages.to_sentence
      end
    else
      # Create a new rating
      @rating = @product.ratings.new(rating_params)
      @rating.user = current_user

      if @rating.save
        @product.update_rating!
        redirect_to product_path(@category, @product), notice: 'Rating submitted successfully!'
      else
        redirect_to product_path(@category, @product), alert: @rating.errors.full_messages.to_sentence
      end
    end
  end

  private

  # Strong parameter method for rating
  def rating_params
    params.require(:rating).permit(:value)
  end
end
