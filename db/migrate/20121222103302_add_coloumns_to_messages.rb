class AddColoumnsToMessages < ActiveRecord::Migration
  def change
    add_column :messages , :can_reply , :boolean , :default => true
    add_column :messages , :is_subscribed , :boolean , :default => true
    add_column :messages , :msg , :text
    add_column :messages , :tag_id , :integer
    add_column :messages , :participant_id , :integer
  end
end
