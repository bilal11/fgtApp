class AddColumnsToFriends < ActiveRecord::Migration
  def change
    add_column :friends, :name, :string
    add_column :friends, :facebook_id, :string
    add_column :friends, :user_id, :integer
  end
end
