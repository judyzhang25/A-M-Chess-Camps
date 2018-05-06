class ApplicationController < ActionController::Base

  # just show a flash message instead of full CanCan exception
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "You are not authorized to take this action."
    redirect_to home_path
  end

  # handle 404 errors with an exception as well
  rescue_from ActiveRecord::RecordNotFound do |exception|
    flash[:error] = "Page cannot be found."
    redirect_to home_path
  end
  
  rescue_from ActionController::RoutingError do |exception|
    flash[:error] = "Page cannot be found."
    redirect_to home_path
  end
  
  private
  def home_bool
    false
  end
  helper_method :home_bool
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  
  def current_role
    if session[:user_id]
      if current_user.role?(:admin) || current_user.role?(:instructor)
        @current_role = Instructor.find_by(user_id: session[:user_id])
      elsif current_user.role?(:parent)
        @current_role = Family.find_by(user_id: session[:user_id])
      else
        @current_role = nil
      end
    end
  end
  helper_method :current_role

  def logged_in?
    current_user
  end
  helper_method :logged_in?

  def check_login
    redirect_to login_url, alert: "You need to log in to view this page." if current_user.nil?
  end
end
