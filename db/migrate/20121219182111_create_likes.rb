class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.string :liker_name
      t.integer :post_id
      t.integer :comment_id
      t.timestamps
    end
  end
end
