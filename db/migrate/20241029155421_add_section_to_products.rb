class AddSectionToProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :section, :string
  end
end
