class AddConfirmableToUsers < ActiveRecord::Migration[7.2]
  def change
    # Remove this if it already exists
    # add_column :users, :confirmation_token, :string

    # Add only the columns that are not yet in the database
    add_column :users, :confirmed_at, :datetime unless column_exists?(:users, :confirmed_at)
    add_column :users, :confirmation_sent_at, :datetime unless column_exists?(:users, :confirmation_sent_at)
    add_column :users, :unconfirmed_email, :string unless column_exists?(:users, :unconfirmed_email) # Only if using reconfirmable

    # Only add index if the column was added in this migration
    add_index :users, :confirmation_token, unique: true unless index_exists?(:users, :confirmation_token)
  end
end
