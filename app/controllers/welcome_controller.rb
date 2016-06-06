class WelcomeController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index]
  def index
  	# @images = Image.all
  	# @images = Image.paginate(page: params[:page], per_page: 10).order(updated_at: :desc)
  	# @instagram = Instagram.media_popular
  	@instagram = Instagram.user_recent_media(9326124, {:count => 20})
  end
end
