class Comment < ActiveRecord::Base
	attr_accessible :body, :commenter, :post_id
	belongs_to :post
  
end
