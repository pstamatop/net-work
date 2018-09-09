class FriendshipsController < ApplicationController
	before_action :logged_in_user

	def create
		current_user.friendships.create(friend: User.find(params[:id]))
		redirect_back(fallback_location: root_path)
	end

	def destroy
		@friendship = Friendship.find_by(user: current_user, 
		                                 friend: User.find(params[:id]))
		@friendship.destroy
		redirect_back(fallback_location: root_path)
	end

end
