class WelcomeController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index]
  def index
  	# @instagram = Instagram.media_popular
  	# @instagram = Instagram.user_recent_media(9326124, {:count => 18})
  	@carousel = []
  	@images = Image.where(user_id: current_user).order(updated_at: :desc)
  	@images.take(5).each do |image|
  		@carousel << image.picture.url
  	end	
  end
end
