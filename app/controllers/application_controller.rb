class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  # before_action :sleep_for_a_bit
  # before_action :set_user, only: [:require_super_user]
  helper_method :current_user, :logged_in?
  


  # def sleep_for_a_bit
  #   sleep 1
  # end

  def logged_in?
  	!!current_user
  end

  def require_admin
    if !current_user.admin
      flash[:danger] = "You must be and admin user to perform that action"
      redirect_to images_path
    end
  end

  def require_user
  	if !logged_in?
  		flash[:danger]= "You must be logged in to perform that action"
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

  def demo_account
    if current_user == User.find_by(email: 'demo@photo-app.com') || current_user == User.find_by(email: "admin@photo-app.com")
      flash[:info] = "Demo accounts cannot create delete or edit. Please Sign Up!!"
      redirect_to :back
    end
  end

end
