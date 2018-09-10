class User < ApplicationRecord
  	has_many :posts, dependent: :destroy
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

    mount_uploader :profilepic, AvatarUploader

    # Returns the hash digest of the given string.
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	def feed
    	Post.where("user_id = ?", id)
  	end
end
