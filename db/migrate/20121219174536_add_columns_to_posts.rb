class AddColumnsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :user_id, :integer
    add_column :posts, :text, :text
    add_column :posts, :poster_name, :string
    add_column :posts, :total_likes, :integer, :default => 0
    add_column :posts, :total_comments, :integer, :default => 0
    add_column :posts, :post_time, :datetime
  end
end
