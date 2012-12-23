class Post < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  has_many :comments
  has_many :likes
  self.inheritance_column = nil
end
