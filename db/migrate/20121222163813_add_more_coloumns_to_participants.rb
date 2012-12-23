class AddMoreColoumnsToParticipants < ActiveRecord::Migration
  def change
    add_column :participants , :email_address , :string
  end
end
