class MessagesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
  	@conversation= Conversation.find(params[:conversation_id])
  	@message = @conversation.messages.create(message_params)
    @message.user_id = current_user.id
    if @message.save
      flash[:success] = "Message sent!"
      @conversation.updated_at = @message.created_at
      @conversation.save
      redirect_to request.referrer
    end
  end

  def destroy
    @conversation= Conversation.find(params[:conversation_id])
    @message = @conversation.messages.find(params[:id])
    @message.destroy
    redirect_to request.referrer
  end

  def index
    @conversation= Conversation.find(params[:conversation_id])
    @messages = @conversation.messages
  end


private

	 def message_params
      params.require(:message).permit(:content)
    end


	 def correct_user
      @message= current_user.messages.find_by(id: params[:id])
      redirect_to root_url if @message.nil?
    end
end
