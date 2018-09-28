class FriendRequestsController < ApplicationController
before_action :logged_in_user

	def accept_request
		current_user.accept_friend_request(User.find(params[:id]))
		redirect_to request.referrer
	end

	def decline_request
		@user = User.find(params[:id])
		request = current_user.pending_requests.find { |friendRequest| friendRequest.request_sender == @user.id}.id
		FriendRequest.destroy(request)
		redirect_to root_url
	end

	def request_friendship
		current_user.request_friendship(User.find(params[:id]))
		redirect_to request.referrer
	end

	def delete_friendship
		current_user.delete_friend_request(User.find(params[:id]))
		redirect_to request.referrer
	end

	def delete_request
		current_user.delete_sent_friend_request(User.find(params[:id]))
		redirect_to request.referrer
	end
end


