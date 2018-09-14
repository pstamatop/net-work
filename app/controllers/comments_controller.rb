class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
  	@post = Post.find(params[:post_id])
  	@comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to request.referrer || root_url
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to request.referrer || root_url
  end

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments.paginate(page: params[:page])
  end


private

	 def comment_params
      params.require(:comment).permit(:content)
    end


	 def correct_user
      @comment= current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end
end
