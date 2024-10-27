class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @comment = Comment.new
    @rating = Rating.new
    @user_rating = current_user ? @product.ratings.find_by(user: current_user) : nil
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  # Action to handle comment creation
  def create_comment
    @product = Product.find(params[:product_id])
    @comment = @product.comments.new(comment_params)
    @comment.user = current_user if user_signed_in?

    if @comment.save
      redirect_to @product, notice: 'Comment was successfully created.'
    else
      redirect_to @product, alert: 'Error creating comment.'
    end
  end

  # Action to handle rating creation or update
  def create_rating
    @product = Product.find(params[:product_id])
    @rating = @product.ratings.find_or_initialize_by(user: current_user)

    if @rating.update(rating_params)
      @product.update_rating!  # Ensure the product's average rating is updated
      redirect_to @product, notice: 'Rating was successfully submitted.'
    else
      redirect_to @product, alert: 'Error submitting rating.'
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :category_id, :image)  # Add :image for file upload
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def rating_params
    params.require(:rating).permit(:value)
  end
end
