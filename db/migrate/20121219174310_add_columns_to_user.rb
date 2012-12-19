class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :facebook_id, :string
    add_column :users, :fb_access_token, :string
    add_column :users, :fb_display_picture_url, :string
  end
end
