class AppliesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
  	@joboffer = Joboffer.find(params[:joboffer_id])
  	if not already_applied?
  		@joboffer.applies.create(user_id: current_user.id)
  	end
      #flash[:success] = "Post created!"
    redirect_to request.referrer
  end

  def destroy
  	if already_applied?
    	@apply.destroy
    end
    redirect_to request.referrer
  end

  def index
    @joboffer = Joboffer.find(params[:joboffer_id])
    @applies = @joboffer.applies.paginate(page: params[:page])
  end


private
	def already_applied?
  		Apply.where(user_id: current_user.id, joboffer_id:params[:joboffer_id]).exists?
	end

	 def correct_user
      @apply = current_user.applies.find_by(id: params[:id])
      redirect_to joboffer_path if @apply.nil?
    end
end
