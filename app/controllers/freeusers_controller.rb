class FreeusersController < ApplicationController
	skip_before_action :authenticate_user!
	before_action :set_user, only: [:edit, :update, :show, :destroy]
	


	def index
		# @users = User.all
		@freeusers = User.paginate(page: params[:page], per_page: 20).order(email: :asc)
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

  def search
    @users = User.search(params[:search_param])
    # puts @images
    if @users
      # @users = current_user.except_current_user(@users)
      render partial: "lookup"
    else
      render status: :not_found, nothing: true
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