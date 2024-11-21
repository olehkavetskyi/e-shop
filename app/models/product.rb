class Product < ApplicationRecord
  # Associations
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_one_attached :image

  # Scopes
  scope :by_section, ->(section) { joins(:category).where(categories: { name: section }) }

  # Methods
  # Calculate the average rating based on associated ratings
  def calculate_average_rating
    ratings.any? ? ratings.average(:value)&.round(1) : nil
  end

  # Update the average_rating attribute with the calculated value
  def update_rating!
    new_average = calculate_average_rating
    update(average_rating: new_average)
  end
end
