class Comment < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :post
  has_many :likes
end
