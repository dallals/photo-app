class FriendsController < ApplicationController
  before_action :set_friend, only: :destory

  def index
  	@friends = current_user.friends
  end

  def destory
  	current_user.remove_friend(@friend)
  	head :no_content
  end


  private

  def set_friend
  	@friend = currentUser.friends.find(params[:id])
  end
end
