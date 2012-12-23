class RenamePostsName < ActiveRecord::Migration
  def up
    rename_table :posts, :feeds
  end

  def down
    rename_table :feeds, :posts
  end
end
