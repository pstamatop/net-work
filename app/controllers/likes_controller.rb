class LikesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
  	@post = Post.find(params[:post_id])
  	if not already_liked?
  		@post.likes.create(user_id: current_user.id)
  	end
      #flash[:success] = "Post created!"
    redirect_to request.referrer || root_url
  end

  def destroy
  	if already_liked?
    	@like.destroy
    end
    redirect_to request.referrer || root_url
  end


private
	def already_liked?
  		Like.where(user_id: current_user.id, post_id:params[:post_id]).exists?
	end

	 def correct_user
      @like = current_user.likes.find_by(id: params[:id])
      redirect_to root_url if @like.nil?
    end
end
