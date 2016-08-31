class FriendRequestsController < ApplicationController
	before_action :set_friend_request, expect: [:index, :create, :new]


	def index
		@incoming = FriendRequest.where(friend: current_user)
		@outgoing = current_user.friend_requests
	end

	def update
		@friend_request.accept
		head :no_content
	end

	def new

	end

	def create
		friend = User.find(params[:friend_id])
		# @friend_request = current_user.friend_request.new(friend: friend)
		@friend_request = Friendship.new(friend_request_params)
		@friend_request.user_id = current_user.id 
		@friend_request.friend_id = params[:friend_id]

		if @friend_request.save
			flash[:success] = "Friend request has been sent to #{friend.full_name}"
			redirect_to images_path
		else
			render json: @friend_request.errors, status: :unprocessable_entity
		end
	end

	def destroy
		@friend_request.destroy
		head :no_content
	end

	private

		# def friend_request_params
	 #  	params.require(:album).permit(:name).merge(user: current_user)
		# end

		def friend_request_params
			params.permit(:friend_id, :user_id)
		end

		def set_friend_request
			@friend_request = FriendRequest.find(params[:id])
		end
end
