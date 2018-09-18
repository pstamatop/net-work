class FriendRequest < ApplicationRecord
	belongs_to :sender, class_name: 'User', foreign_key: "request_sender"
	belongs_to :receiver, class_name: 'User', foreign_key: "request_receiver"

	enum status: [:pending, :accepted]

	validates  :receiver, uniqueness: { scope: :sender }
end
