class AddColumnsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :text, :text
    add_column :comments, :comment_time, :datetime
    add_column :posts, :fb_post_id, :integer
  end
end
