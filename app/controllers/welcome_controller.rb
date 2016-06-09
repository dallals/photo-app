class WelcomeController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index]
  def index
  	# @instagram = Instagram.media_popular
  	# @instagram = Instagram.user_recent_media(9326124, {:count => 18})
  	# @images = Image.all.order(updated_at: :desc)
  	# @images = Image.joins(:user).where(:users => {:user_id => current_user.id })
  	# @images = Image.find(current_user.id).order(updated_at: :desc)
  	# @comments = Comment.joins(:post).where(:posts => { :user_id => @user.id })
  	@images = Image.where(user_id: current_user)
  end
end
