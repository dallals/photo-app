class WelcomeController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index]
  def index
  	# @images = Image.all
  	@images = Image.paginate(page: params[:page], per_page: 10).order(updated_at: :desc)
  end
end
