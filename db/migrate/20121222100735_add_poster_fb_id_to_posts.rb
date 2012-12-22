class AddPosterFbIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :poster_fb_id, :string
  end
end
