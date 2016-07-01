class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  helper_method :current_user, :logged_in?
  



  def logged_in?
  	!!current_user
  end

  def require_user
  	if !logged_in?
  		flash[:danger]= "You must be logged in to perform that action"
  		redirect_to :back
  	end
  end
  def super_user
    @super_user = User.find(1)
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def local_request?
    false
  end

end
