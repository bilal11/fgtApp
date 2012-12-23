class ChangeStructureOfMailbox < ActiveRecord::Migration
  def change
    add_column :conversations , :message_id , :integer
    add_column :conversations , :tag_id , :integer
    add_column :conversations , :participant_id , :integer
    add_column :conversations , :snippet , :text
    remove_column :messages , :tag_id
    remove_column :messages , :participant_id
  end
end
