class Friendship < ApplicationRecord
	belongs_to :user, class_name: 'User', foreign_key: "user_id"
	belongs_to :friend, class_name: 'User', foreign_key: "friend_id"
	after_create :delete_friend_request, :inverse_friendship
	after_destroy :destroy_inverse_friendship
	validates :user_id, presence: true
    validates :friend_id, presence: true

	def inverse_friendship
		unless Friendship.find_by(user: self.friend_id, friend: self.user_id)
			Friendship.create(user: self.friend, friend: self.user)
		end
	end

	def destroy_inverse_friendship
		if Friendship.find_by(user: self.friend_id, friend: self.user_id)
			Friendship.find_by(user: self.friend, friend: self.user).destroy 
		end
	end  
end
