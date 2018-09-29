class ConversationsController < ApplicationController
	before_action :logged_in_user, only: [:show]
  	#before_action :correct_user,   only: :destroy


	def show
    	@conversation = Conversation.find(params[:id])
  	end
end
