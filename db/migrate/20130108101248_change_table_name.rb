class ChangeTableName < ActiveRecord::Migration
  def change
    rename_table :feeds, :posts
  end
end
