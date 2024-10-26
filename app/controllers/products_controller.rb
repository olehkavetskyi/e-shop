class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @comment = Comment.new  # Create a new instance for the form
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

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :category_id)
  end
  # product comments

  def create_comment
    @product = Product.find(params[:product_id])
    @comment = @product.comments.new(comment_params)
    @comment.user = current_user if user_signed_in?  # Associate the comment with the current user

    if @comment.save
      redirect_to @product, notice: 'Comment was successfully created.'
    else
      redirect_to @product, alert: 'Error creating comment.'
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :category_id, :image)  # Add :image here
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
