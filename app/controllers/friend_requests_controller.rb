class FriendRequestsController < ApplicationController
before_action :logged_in_user

	def accept_request
		current_user.accept_friend_request(User.find(params[:id]))
		redirect_to user_friend_requests_path(@current_user)
	end

	def decline_request
		@user = User.find(params[:id])
		request = current_user.pending_requests.find { |friendRequest| friendRequest.request_sender == @user.id}.id
		FriendRequest.destroy(request)
		redirect_to user_friend_requests_path(@current_user)
	end

end


