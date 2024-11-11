class Product < ApplicationRecord
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy  # This assumes you have a separate Rating model
  has_one_attached :image
  scope :by_section, ->(section) { where(section: section) }

  def calculate_average_rating
    ratings.average(:value)
  end

  def update_rating!
    update(average_rating: calculate_average_rating)
  end
end
