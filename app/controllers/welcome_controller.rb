class WelcomeController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index]
  def index
  	# @instagram = Image.all
  	# @images = Image.paginate(page: params[:page], per_page: 10).order(updated_at: :desc)
  	# @instagram = Instagram.media_popular
  	@instagram = Instagram.user_recent_media(9326124, {:count => 18})
  	@images = Image.all.order(updated_at: :desc)
  	# @results = Google::Search::News.new(query: "President Obama")

  end
end
