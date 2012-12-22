class AddMoreColumnsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :post_name, :string
    add_column :posts, :type, :string
    add_column :posts, :status_type, :string
    add_column :posts, :picture_url, :string
    add_column :posts, :shared_pic_link, :string
    add_column :comments, :commenter_fb_id, :string
    add_column :likes, :liker_fb_id, :string
  end
end
