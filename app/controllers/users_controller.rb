class UsersController < ApplicationController
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
    before_action :correct_user,   only: [:edit, :update]
    before_action :admin_user,     only: [:destroy, :export]

    def destroy
		User.find(params[:id]).destroy
		for freq in FriendRequest.all
        	if freq.request_sender == params[:id] || freq.request_receiver == params[:id] 
        		freq.destroy
        	end
        end
        for conversation in Conversation.all
        	if conversation.user_id == params[:id] || conversation.receiver == params[:id] 
        		conversation.destroy
        	end
        end
		flash[:success] = "User deleted"
		redirect_to users_url
    end

	def index
		if params[:search]
    		@users = User.search(params[:search]).order("created_at DESC")
    	else
	    	# @users = User.paginate(page: params[:page])
	    	@users = User.all
	    end
    end

	def new
	    @user = User.new
	end

	def show
	    @user = User.find(params[:id])
	    #posts = @user.posts.paginate(page: params[:page])
	end

	def create
    @user = User.new(user_params)
	    if @user.save
          log_in @user
	      flash[:success] = "Welcome to net-work!"
      	  redirect_to root_path
	    else
	      render 'new'
	    end
  	end

  	def edit
	    @user = User.find(params[:id])
	end

	def update
    	@user = User.find(params[:id])
	    if @user.update_attributes(user_params)
			flash[:success] = "Profile updated"
      		redirect_to @user
	    else
	    	render 'edit'
	    end
	end

	def export_all
		current_user.export_all
		redirect_to request.referrer
	end

	def export
		@user = User.find(params[:id])
		current_user.export(@user)
		redirect_to request.referrer
	end

	private
	    def user_params
	    	params.require(:user).permit(:firstName, :lastName, :email, :phone, :password,
	                               :password_confirmation,:curwork,:prevwork,:education,:profilepic,:curwork_ispublic,:prevwork_ispublic,:education_ispublic,:skills_ispublic,{tskill_ids: []})
    	end

    	# Before filters

	    # Confirms the correct user.
	    def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless current_user?(@user) || current_user.admin?
	    end

	    # Confirms an admin user.
	    def admin_user
			redirect_to(root_url) unless current_user.admin?
	    end
end
