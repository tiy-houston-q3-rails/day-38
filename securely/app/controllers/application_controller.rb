class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def authenticate_user!
    # if already logged in, cool
    # else send to a login page

    if current_user
      return true
    else
      redirect_to new_session_path
    end
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end
end
