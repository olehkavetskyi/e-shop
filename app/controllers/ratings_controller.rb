class RatingsController < ApplicationController
  def create
    # Find the product based on the category and id
    @category = Category.find_by!(name: params[:category])
    @product = @category.products.find(params[:id])

    @rating = @product.ratings.new(rating_params)
    @rating.user = current_user

    if @rating.save
      @product.update_rating!
      redirect_to product_path(@category, @product), notice: 'Rating submitted!'
    else
      redirect_to product_path(@category, @product), alert: 'Failed to submit rating.'
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:value)
  end
end
