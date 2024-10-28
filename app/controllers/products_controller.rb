class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @brands = Product.distinct.pluck(:brand)  # Fetch unique brands for filtering
    @products = Product.all

    # Filtering by price range and brand
    if params[:min_price].present? || params[:max_price].present?
      min_price = params[:min_price].present? ? params[:min_price].to_f : 0
      max_price = params[:max_price].present? ? params[:max_price].to_f : Float::INFINITY

      @products = @products.where(price: min_price..max_price)
    end

    if params[:brand].present?
      @products = @products.where(brand: params[:brand])
    end

    # Pagination (assuming 12 products per page)
    @products = @products.page(params[:page]).per(2)
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
    params.require(:product).permit(:name, :description, :price, :stock, :brand, :category_id, :image)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def rating_params
    params.require(:rating).permit(:value)
  end
end
