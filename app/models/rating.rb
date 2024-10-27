class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :value, presence: true, inclusion: { in: 1..5 }  # Assuming ratings are from 1 to 5
end
