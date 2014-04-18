class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?
  
  def sign_in(user)
    auth_token = User.generate_token
    user.update_attribute(:auth_token, User.hash(auth_token))
    cookies.permanent[:auth_token] = auth_token
    current_user = user
  end
  
  def current_user=(user)
    @current_user ||= user
  end
  
  def current_user
    auth_token = User.hash(cookies[:auth_token])
    @current_user ||= User.find_by_auth_token(auth_token) if cookies[:auth_token]
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def signed_in
    unless signed_in?
      flash[:error] = 'Please sign in.'
      redirect_to sign_in_path
    end
  end
end
