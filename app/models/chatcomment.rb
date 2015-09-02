class Chatcomment < ActiveRecord::Base

  
  belongs_to :user

  
  default_scope -> { order(created_at: :desc) }
  
  
 validates :body, presence: true, length: {maximum: 2000}



 class << self
    def remove_excessive!
      if all.count > 100
        first(50).delete_all
      end
    end

end
end

