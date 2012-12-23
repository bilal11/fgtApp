class Participant < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :conversation
end
