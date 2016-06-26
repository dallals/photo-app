class FreeusersController < ApplicationController
	skip_before_action :authenticate_user!
	before_action :set_user, only: [:edit, :update, :show, :destroy, :index]
	


	def index
		
	end

    def show
    	@images = Image.all.order(updated_at: :desc)
    end

	def destroy
		if !@user.admin?
	  	@user.destroy
	  	flash[:danger] = "User and all images and albums have been deleted"
	  	redirect_to images_path
	  else
	  	flash[:danger] = "You can not delete an Admin account"
	  	redirect_to :back
	  end
  	end 

	# def login
	# 	user = Finduser.find_by(email:params[:session][:email].downcase)
	# 		if user && user.authenticate(params[:session][:password])
	# 			session[:user_id] = freeuser.id
	# 			@current_user = Freeuser.find(session[:user_id])
	# 			flash[:success] = "You are logged in"
	# 			redirect_to images_path(user)
	# 		else
	# 		flash.now[:danger] = "Invalid email or password"
	# 		render :new	
	# 	end
	# end	
	private

	def set_user
		@user = User.find(params[:id])
	end


end