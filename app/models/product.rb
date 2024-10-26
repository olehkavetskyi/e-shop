class Product < ApplicationRecord
  belongs_to :category
  has_many :comments, dependent: :destroy  # Add this line to associate products with comments
  has_one_attached :image
end
