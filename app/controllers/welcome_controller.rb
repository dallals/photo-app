class WelcomeController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index]
  def index
  	# @instagram = Instagram.media_popular
  	# @instagram = Instagram.user_recent_media(9326124, {:count => 18})
  	@images = Image.all.order(updated_at: :desc)
  	# @images = Image.find(current_user.id).order(updated_at: :desc)

  end
end
