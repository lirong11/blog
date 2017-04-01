require 'grape'
require "#{Rails.root}/app/api/blog/entities_base"
module Blog
	class Blog::API < Grape::API
		version 'v1',using: :header,vendor: 'twitter'
		format :json
		prefix :api

		# helpers do 
		# 	def current_user
		# 		@current_user ||=User.authorize!(env)
		# 	end

		# 	def authenticate!
		# 		error!('401 Unauthorized',401) unless current_user
		# 	end
		# end
        resource :post do
        	desc "Return a post"
        	params do
        		# requires :id, type: Integer, desc: "Posts id."
        	end
        	
    		get "/:id" do
    			post = ::Post.find(params[:id])
    			present post, :with => ::BPost
    		end

            desc "Create a post."
            params do
            	requires :name, type: String
            	requires :title, type:String
            	requires :content, type:String
            	# optional :comments, type:Comment
            end
            post do
            
            	post = ::Post.create(name: params[:name],title: params[:title],content: params[:content]) 
            	present post, :with => ::BPost
            end

            desc "Return all Post"

            get do
            	::Post.all
            end

            desc "Delete a post"

            delete "/:id" do
            	post = ::Post.find(params[:id])
                if post.nil? 
                	
                else
                	::Post.destroy(params[:id]).to_s

                end
            	
            end

            # desc "Update a post"
            # params do
            #     optional :title, type: String
            #     optional :name, type: String
            #     optional :content, type: String

                  
            # end
            # put "/:id" do

            #     post = ::Post.find(params[:id])
            #     if post.nil?
            #     	{code:400}
            #     else
                	
            #     	_attr = {}
            #     	_attr[:name] = params[:name] if params[:name]  
            #     	_attr[:title] = params[:title] if params[:title]
            #         _attr[:content] = params[:content] if params[:content]	

            #     	post.update_attributes(_attr)
                
            #     	# ::Post.update(params[:id],)

            #     end
            # end
	
        end

        resource :comment do
        	get "/:id" do
        		comment = ::Comment.find(params[:id])
        		present comment, :with => ::BComment

        	end

            desc "get all comment"
            get do
                ::Comment.all
            end

        	desc "Create a comment"
        	params do
        		requires :post_id, type:Integer
        		requires :commenter, type:String
        		requires :body, type:String
        	end

        	post do
        		comment = ::Comment.create(post_id: params[:post_id], commenter: params[:commenter], body: params[:body])
        		present comment, :with => ::BComment
        	end

            desc "Delete a comment"

            delete "/:id" do
                comment = ::Comment.find(params[:id])
                if comment.nil?
                    
                else
                    ::Comment.destroy(params[:id]).to_s
                end
            end

            desc "update a comment"
            params do
                optional :body, type:String
                optional :commenter, type:String

            end

            put "/:id" do
                comment = ::Comment.find(params[:id])
                if comment.nil?
                    
                else
                    _attr_comment = {}
                    _attr_comment[:body] = params[:id] if params[:id]
                    _attr_comment[:commenter] = params[:commenter] if params[:commenter]

                    comment.update_attributes(_attr_comment)
                end
            end



        end

		resource :blog do
			desc "Return a public timeline."
			get :my_blog do
				{my_blog: 1}
			end



			# desc "Return a personal timeline."
			# get :home_timeline do
			# 	authenticate!
			# 	current_user.statuses.limit(20)
			# end

			# desc "Return a status."
			# params do
			# 	requires :id, type: Integer, desc: "Status id."
			# end
			# route_param :id do
			# 	get do
			# 		Status.find(params[:id])
			# 	end
			# end

			# desc "Create a status."
			# params do
			# 	requires :status, type: String, desc: "Your status."
			# end
			# post do
			# 	authenticate!
			# 	Status.create!({
			# 		user: current_user,
			# 		text: params[:status]
			# 		})
			# end

			# desc "Update a status."
			# params do
			# 	requires :id, type: String, desc: "Status ID."
			# 	requires :status, type: String, desc: "Your status."
			# end
			# put ':id' do
			# 	authenticate!
			# 	current_user.statuses.find(params[:id]).update({
			# 		user: current_user,
			# 		text: params[:status]
			# 		})
			# end

			# desc "Delete a status."
			# params do
			# 	requires :id, type: String, desc: "Status ID."
			# end
			# delete ':id' do
			# 	authenticate!
			# 	current_user.statuses.find(params[:id]).destroy
			# end
		end
	end
end
