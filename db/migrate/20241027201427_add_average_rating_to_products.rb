class AddAverageRatingToProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :average_rating, :float
  end
end
