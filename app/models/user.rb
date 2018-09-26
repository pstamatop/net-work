class User < ApplicationRecord
  	has_many :posts, dependent: :destroy
  	has_many :likes, dependent: :destroy
  	has_many :comments, dependent: :destroy
	has_many :friend_requests, dependent: :destroy, source: 'receiver_id'
	has_many :joboffers, dependent: :destroy
	has_many :applies, dependent: :destroy

	has_and_belongs_to_many :tskills


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
		#liked_posts = Post.where("id IN (?)",(friends.find {|f| f.likes.find {|l| l.post_id}}))
		liked_posts = []

		if friends.any?
          friends.each do |friend|
          	if friend.likes.any?
          		friend.likes.each do |like|
          			liked_posts.push(like.post_id)
          		end
          	end
          end
        end
    	#Post.where("user_id = ?", id)
    	Post.where("user_id IN (?) OR user_id = ? OR id IN (?)", friends.ids, id, liked_posts)
  	end

  	def jobofferfeed
		#liked_posts = Post.where("id IN (?)",(friends.find {|f| f.likes.find {|l| l.post_id}}))
    	#Post.where("user_id = ?", id)
    	Joboffer.where("user_id IN (?)", friends.ids)
  	end

  	def get_applies
  		total_applies = []

		if joboffers.any?
  			joboffers.each do |joffer|
  				if joffer.applies.any?
          			joffer.applies.each do |apply|
          				total_applies.push(apply)
          			end
          		end
          	end
        total_applies.sort_by(&:created_at).reverse
  		end
  	end

  	def friends
		ids = FriendRequest.where('request_receiver = ? OR request_sender = ?', id, id)
			.where(status: :accepted).pluck(:request_receiver, :request_sender)
			.flatten - [id]
		User.where(id: ids)
	end

	def pending_requests
		FriendRequest.where('request_receiver = ? ', id)
					 	.where(status: :pending)
	end

	def get_user_from_pending_requests
		User.find(pending_requests.pluck(:request_sender))
	end

	def request_friendship(other_user)
		FriendRequest.create request_sender: id,
								request_receiver: other_user.id,
								status: :pending
	end

	def accept_friend_request(other_user)
		FriendRequest.where(request_sender: other_user.id).update status: :accepted
	end

	def friends_with?(other_user)
		(FriendRequest.where(request_sender: id, request_receiver: other_user.id).where(status: :accepted).any? ||
		FriendRequest.where(request_sender: other_user.id, request_receiver: id).where(status: :accepted).any?)
	end
end
