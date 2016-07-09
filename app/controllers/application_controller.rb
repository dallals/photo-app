class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  # before_action :set_user, only: [:require_super_user]
  helper_method :current_user, :logged_in?
  



  def logged_in?
  	!!current_user
  end

  def require_admin
    if !current_user.admin
      flash[:danger] = "You must be admin to perform that action"
      redirect_to images_path
    end
  end

  def require_user
  	if !logged_in?
  		flash[:danger]= "You must be logged in to perform that action"
  		redirect_to :back
  	end
  end

  def require_super_user
    unless current_user == User.find_by(email: 'sammydallal@gmail.com')
      flash[:info] = "You must be the appilcation owner to perform that action"
      redirect_to :back
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def local_request?
    false
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
