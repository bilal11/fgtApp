class ChangeColumnOfTables < ActiveRecord::Migration
  def up
    change_column :posts, :post_time, :string
    change_column :comments, :comment_time, :string
  end

  def down
    change_column :posts, :post_time, :datetime
    change_column :comments, :comment_time, :datetime
  end
end
