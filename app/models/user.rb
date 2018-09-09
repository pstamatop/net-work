class User < ApplicationRecord
	has_many  :friendships, class_name: "Friendship", foreign_key: 'user_id'
  	has_many  :friends, through: :friendships, source: 'friend'
  	has_many  :friend_requests, class_name: "FriendRequest", foreign_key: 'request_user'
	has_many  :requests_received, class_name: "FriendRequest", foreign_key: 'request_friend'

	# has_many :friendships
	# has_many :friends, :through => :friendships
	# has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
	# has_many :inverse_friends, :through => :inverse_friendships, :source => :user

	before_save { self.email = email.downcase }
	validates :firstName, presence: true, length: { maximum: 50 }
	validates :lastName, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 }, 
			  format: { with: VALID_EMAIL_REGEX }, 
			  uniqueness: { case_sensitive: false }
	validates :phone, presence: true, length: { maximum: 20 }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    # Returns the hash digest of the given string.
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end
end
