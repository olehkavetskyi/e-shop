class AddRatingToComments < ActiveRecord::Migration[7.2]
  def change
    add_column :comments, :rating, :integer
  end
end
