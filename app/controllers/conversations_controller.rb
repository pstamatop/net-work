class ConversationsController < ApplicationController
	before_action :logged_in_user, only: [:show, :index]
  	#before_action :correct_user,   only: :destroy

  	def destroy
      @conversation = Conversation.find(params[:id])
    	@conversation.destroy
    	flash[:success] = "Conversation deleted."
    	redirect_to conversations_path
  	end

	def show
    	@conversation = Conversation.find(params[:id])
  	end

  	def index
    	@conversations = current_user.conversationfeed.paginate(page: params[:page])
    end
end
