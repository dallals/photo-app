class FreeusersController < ApplicationController
	skip_before_action :authenticate_user!
	before_action :set_user, only: [:edit, :update, :show, :destroy]
	

	def new
		@user = Freeuser.new
	end


	def create
  		@user = Freeuser.new(free_user_params)
  		if @user.save
  		# session[:user_id] = @user.id "to sign in at log in"
  		# UserMailer.sample_email(@user).deliver
  		flash[:success] = "Welcome to the Photo-App"
  		redirect_to root_path
  		else
  		render :new
  	 end	
    end

    def edit
    end

	def destroy
		if !@user.admin?
	  	@user.destroy
	  	flash[:danger] = "User and all images and albums have been deleted"
	  	redirect_to root_path
	  else
	  	flash[:danger] = "You can not delete an Admin account"
	  	redirect_to :back
	  end
  	end


	def update
	  if @user.update(user_params)
	  flash[:success] = "Account Updated"
	  	redirect_to freeusers_path
	  else
	  	render :back
	  	end		
	end  

	def login
		user = Finduser.find_by(email:params[:session][:email].downcase)
			if user && user.authenticate(params[:session][:password])
				session[:user_id] = freeuser.id
				@current_user = Freeuser.find(session[:user_id])
				flash[:success] = "You are logged in"
				redirect_to images_path(user)
			else
			flash.now[:danger] = "Invalid email or password"
			render :new	
		end
	end	

	def logout
		session.clear
		flash[:success] = "You have logged out"
		redirect_to root_path
	end


	private

	def free_user_params
		params.require(:freeuser).permit(:email, :password)
	end

	def set_user
		@user = User.find(params[:id])
	end

	# def current_user
	# 	current_user = Freeuser.find(params[:id])
	# end

end