class Category < ApplicationRecord
  has_many :products
  has_many :subcategories, class_name: "Category", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Category", optional: true

  scope :main_categories, -> { where(parent_id: nil) }
end
