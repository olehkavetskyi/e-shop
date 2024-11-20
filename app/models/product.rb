class Product < ApplicationRecord
  # Associations
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_one_attached :image

  # Scopes
  scope :by_section, ->(section) { joins(:category).where(categories: { name: section }) }

  # Methods
  def calculate_average_rating
    return nil if ratings.empty?

    ratings.average(:value)&.round(1)
  end

  def update_rating!
    new_average = calculate_average_rating

    update(average_rating: new_average)
  end
end
