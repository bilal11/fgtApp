class AddCommentFbIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :comment_fb_id, :string
  end
end
