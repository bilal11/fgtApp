class User < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :posts
  has_many :events
  has_many :friends
  has_many :conversations
end
