class AddStotyToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :story, :text
  end
end
