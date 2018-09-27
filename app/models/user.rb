class User < ApplicationRecord

	require 'knn'

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
  		# KNN
  		# remove my job offers from test set
  		test_joboffers = []
  		for jo in Joboffer.all
  			if jo.user_id != id
				test_joboffers.push(jo)
			end
  		end

  		if test_joboffers.length > 50
  			# keep only 50 job offers, delete firrst n elements
  			n =  test_joboffers.length-50
  			test_joboffers.drop(n)

  		end

  		vectors = []
  		users_checked = []
  		# implement current_user  as vector
  		curuser_tupple = []
  		for offer in test_joboffers
  			instance_variable_set("@uservector_#{id}",[])
  			if applies.find_by(:joboffer_id => offer.id)
  				# push value 1 if user has applied for this job
  				instance_variable_get("@uservector_#{id}").push(1)
  			else
  				instance_variable_get("@uservector_#{id}").push(0)
  			end
  		end
  		curuser_tupple = Knn::Vector.new(instance_variable_get("@uservector_#{id}"),id)
  		vectors.push(curuser_tupple)
  		users_checked.push(id)
  		# implement his friends' friends as vectors
  		
  		for check_friend in friends
  			for user in check_friend.friends
  				user_tupple = []
  				if friends.include? user
  					# continue if friend is mutual
  					next
  				end
  				# continue if user has been already checked
  				if users_checked.include? user.id
  					next
  				end
  				instance_variable_set("@uservector_#{user.id}",[])
  				# first element of each vector is user's id
  				#instance_variable_get("@uservector_#{user.id}").push(user.id)
  				for offer in test_joboffers
  					if user.applies.find_by(:joboffer_id => offer.id)
  						# push value 1 if user has applied for this job
  						instance_variable_get("@uservector_#{user.id}").push(1)
  					else
  						instance_variable_get("@uservector_#{user.id}").push(0)
  					end
  				end
  				vectors.push(Knn::Vector.new(instance_variable_get("@uservector_#{user.id}"),user.id))
  				users_checked.push(user.id)
  			end
  		end

  		classifier = Knn::Classifier.new(vectors, 9)

		classifier.classify(curuser_tupple)
  		get_from_knn = classifier.nearest_neighbours_to(curuser_tupple)

  		extra_via_knn = []
  		for item in get_from_knn
  			@user = User.find(item.label)
  			# get the job offers that this user has applied
  			for apply in @user.applies
  				@joboffer = Joboffer.find(apply.joboffer_id)
  				if @joboffer.user_id != id
  					extra_via_knn.push(@joboffer)
  				end
  			end
  		end

		extra_via_skills = []
		common = 0
		for joffer in Joboffer.all
			for jo_skill in joffer.tskills
				if tskills.include? jo_skill
					common = common + 1;
				end
			end
			if (common/joffer.tskills.count) >= 0.7
				if joffer.user_id != id
					extra_via_skills.push(joffer)
				end
			end
			common = 0	
		end

		
    	Joboffer.where("user_id IN (?) OR id IN (?) OR id IN (?)", friends.ids, extra_via_skills, extra_via_knn)
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
