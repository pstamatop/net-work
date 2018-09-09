class FriendRequest < ApplicationRecord
	belongs_to :user, class_name: 'User', foreign_key: "request_user"
	belongs_to :friend, class_name: 'User', foreign_key: "request_friend"
	validates  :friend, uniqueness: { scope: :user }
end
