class JoboffersController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @joboffer = current_user.joboffers.build(joboffer_params)
    if @joboffer.save
      flash[:success] = "Job Offer created!"
      redirect_to joboffers_path
    else
      @feed_items = []
      render 'joboffers/index'
    end
  end

  def destroy
    @joboffer.destroy
    flash[:success] = "Job Offer deleted."
    redirect_to request.referrer
  end


  def index
  	@joboffer  = current_user.joboffers.build
    @joboffers = current_user.jobofferfeed.paginate(page: params[:page])
  end


  private

    def joboffer_params
      params.require(:joboffer).permit(:title,:description)
    end

    def correct_user
      @joboffer = current_user.joboffers.find_by(id: params[:id])
      redirect_to request.referrer if @joboffer.nil?
    end

end
