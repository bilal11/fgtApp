class AddColumnsToParticipants < ActiveRecord::Migration
  def change
    add_column :participants , :name , :string
    add_column :participants , :facebook_id , :string
    add_column :participants , :is_sender , :boolean
    add_column :messages , :msg_time , :datetime
  end
end
