class AddParentIdToCategories < ActiveRecord::Migration[7.2]
  def change
    add_column :categories, :parent_id, :integer
    add_index :categories, :parent_id
  end
end
