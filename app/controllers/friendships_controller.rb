class FriendshipsController < ApplicationController
before_action :logged_in_user

	def index
		@friends = current_user.friends
		@pending_requests = current_user.pending_requests
		@users_with_pending_requests = current_user.get_user_from_pending_requests
	end

	# def create
	# 	@user = User.find(params[:id])
	# end

end

 