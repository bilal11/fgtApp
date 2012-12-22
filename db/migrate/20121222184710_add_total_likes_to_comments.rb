class AddTotalLikesToComments < ActiveRecord::Migration
  def change
    add_column :comments, :total_likes, :integer, :default=>0
  end
end
