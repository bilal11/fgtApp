class Conversation < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  has_many :messages
  has_many :tags
  has_many :participants
end
