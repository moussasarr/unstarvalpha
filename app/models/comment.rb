class Comment < ActiveRecord::Base
include PublicActivity::Model

tracked owner: ->(controller, model) { controller && controller.current_user }
  #tracked :owner => proc {|controller, model| controller.current_user}, # set owner to current_user by default (check app/controllers/application_controller.rb)
          #:params => {
               # by default save truncated summary of the post's body
          #}
  belongs_to :post
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :body,  presence: true, length: { minimum: 10 }
  
  has_reputation :votes, source: :user, aggregated_by: :sum


   def is_empty
   	return true if this.body.empty?

   end
end