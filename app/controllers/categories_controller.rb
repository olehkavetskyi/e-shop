# app/controllers/categories_controller.rb
class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products
  end

  def search
    query = params[:query].downcase
    @categories = Category.where("lower(name) LIKE ?", "%#{query}%").limit(10)

    render json: { categories: @categories }
  end
end
