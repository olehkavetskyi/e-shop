class Product < ApplicationRecord
  belongs_to :category
  has_many :comments, dependent: :destroy  # Associate products with comments
  has_many :ratings, dependent: :destroy    # Associate products with ratings
  has_one_attached :image
  scope :by_section, ->(section) { where(section: section) }


  def average_rating
    ratings.average(:value) # Assuming you have a Rating model with a `value` attribute
  end

  def update_rating!
    self.update(average_rating: average_rating)
  end

end
