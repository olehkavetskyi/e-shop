class CreateCommentLikes < ActiveRecord::Migration[7.2]
  def change
    create_table :comment_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :comment, null: false, foreign_key: true
      t.boolean :like

      t.timestamps
    end
  end
end