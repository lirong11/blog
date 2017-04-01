require "grape-entity"
# module Blog
	# module Entities
	    class BComment < ::Grape::Entity
            expose :id, :body, :post_id , :commenter, :created_at, :updated_at 
	    end
	    class BPost < ::Grape::Entity
		    expose :id, :name, :title, :content, :created_at, :updated_at 
		    expose :comments, using: BComment do |e,o|
		    	#binding.pry
		    	e.comments
		    	#::Blog::Comment.represent(e.comments,o).as_json
		    end
	    end

	   

    # end
# end
