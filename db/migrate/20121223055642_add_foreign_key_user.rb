class AddForeignKeyUser < ActiveRecord::Migration
  def change
    add_column :users , :conversation_id , :integer
  end
end
