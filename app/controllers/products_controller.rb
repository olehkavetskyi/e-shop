class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :ensure_admin, only: [:new, :create]  # Ensure only admins can access these actions

  def index
    @brands = Product.distinct.pluck(:brand)
    @section = params[:section]   # Get section from URL
    @products = Product.all

    # Filter products by section if provided
    if @section.present?
      @products = @products.where("lower(section) = ?", @section.downcase)
    end

    # Apply additional filters for price and brand
    if params[:min_price].present? || params[:max_price].present?
      min_price = params[:min_price].to_f
      max_price = params[:max_price].present? ? params[:max_price].to_f : Float::INFINITY
      @products = @products.where(price: min_price..max_price)
    end

    if params[:brand].present?
      @products = @products.where(brand: params[:brand])
    end

    # Sorting logic based on :sort_by parameter
    case params[:sort_by]
    when 'price_asc'
      @products = @products.order(price: :asc)
    when 'price_desc'
      @products = @products.order(price: :desc)
    when 'name_asc'
      @products = @products.order(name: :asc)
    when 'name_desc'
      @products = @products.order(name: :desc)
    end

    # Paginate results
    @products = @products.page(params[:page]).per(12)
  end

  def show
    @section = params[:section]
    @product = Product.find_by(id: params[:id], section: @section)

    # Redirect if the product isn't found in the specified section
    if @product.nil?
      redirect_to products_path, alert: "Product not found in the specified section."
      return
    end

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

  private

  def ensure_admin
    unless current_user.role == 'admin'  # Checking if the user has admin role
      redirect_to root_path, alert: 'You are not authorized to access this page.'
    end
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :brand, :category_id, :image, :section)
  end

  def comment_params
    params.require(:comment).permit(:content, :parent_id)
  end

  def rating_params
    params.require(:rating).permit(:value)
  end
end
