class Groupcomment < ActiveRecord::Base
	include PublicActivity::Model
	
	belongs_to :user
	belongs_to :groupost
	belongs_to :group
	
    validates :body, presence: true, length: { minimum:5}
end
