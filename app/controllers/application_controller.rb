class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  private
  
  def require_login
    unless logged_in?
      flash[:error_github] = "You must be logged in to access this section"
      redirect_to root_url # halts request cycle
    end
  end

  def require_admin
    unless current_user.admin?
      flash[:error_github] = "You must be admin to access this section"
      redirect_to root_url # halts request cycle
    end      
  end

  def logged_in?
    !!current_user
  end
 
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
