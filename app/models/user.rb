class User < ActiveRecord::Base

 



include PublicActivity::Model
tracked owner: ->(controller, model) { controller && controller.current_user }
  
acts_as_messageable
 mount_uploader :picture, PictureUploader
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable, 
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable
      :confirmable
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
 groupify :group_member
 groupify :named_group_member
 has_many :chatcomments, dependent: :delete_all
 has_many :friendships
 has_many :friends, :through => :friendships
 has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
 has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_many :conversations, :foreign_key => :sender_id
has_many :grouposts, dependent: :destroy
has_many :posts, dependent: :destroy
has_many :comments, dependent: :destroy
has_many :groupcomments, :through => :grouposts,  dependent: :destroy
has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy

has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy



has_many :following, through: :active_relationships, source: :followed  
has_many :followers, through: :passive_relationships, source: :follower

ARTIST = ["No", "Want to hire artists", "Short story writer", "Novelist",  "Poet",  "Photographer", "Comedian", "Comic writer", "Screenwriter", "Singer",  "Songwriter", "Painter",  "Graphic Designer",  "Illustrator",  "Actor"]
validate  :picture_size


 acts_as_messageable

  #def mailboxer_email(object)
   # email
  #end

  

  def updated?
    if (!self.username.nil? && !self.firtname.nil? && !self.lastName.nil? && !self.country.nil? && !self.state.nil? && !self.industry.nil? )
      return true
    else
      return false
  end
end

    #def name
      # return self.username || self.firtname
    #end
    
    #def mailboxer_email(object)
  #Check if an email should be sent for that object
  # if pendin_email
  #return "define_email@on_your.model"
  #if false
  #return nil
#end

    def current_user?(user)
    user == current_user
    end
    
    def active_for_authentication?
     super && !!active
     end
    
    def active?
     !!active
    end

    def inactive_message
     "Sorry, this account has been deactivated."
    end

    def soft_delete
    # assuming you have deleted_at column added already
    update_attribute(:deleted_at, Time.current)
    update_attribute(:active, :false)

    end

    

    def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
     end

  # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  # 
  def like(other_user)
     
  end
  


  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          username: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation! if user.respond_to?(:skip_confirmation)
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end
end