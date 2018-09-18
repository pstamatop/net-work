class FriendshipsController < ApplicationController
before_action :logged_in_user

	def index
		@friends = current_user.friends
		@users_with_pending_requests = current_user.get_user_from_pending_requests
	end

end

