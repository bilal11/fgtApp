class ChangeColumnOfPosts < ActiveRecord::Migration
  def up
    change_column :posts, :fb_post_id, :string
  end

  def down
    change_column :posts, :fb_post_id, :integer
  end
end
