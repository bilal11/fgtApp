class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :post_id
      t.string :commenter_name
      t.timestamps
    end
  end
end
