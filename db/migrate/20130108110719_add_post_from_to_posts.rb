class AddPostFromToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :post_from, :string
  end
end
