class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :find_post_by_prompt
  
  def find_post_by_prompt(prompt)
    current_user.posts.find_by(prompt: prompt)
  end

  def current_user
    return nil unless session[:token]
    @current_user ||= User.find_by(token: session[:token])
  end

  def logged_in?
    !!current_user
  end

  def login(user)
    @current_user = user
    session[:token] = user.reset_token!
  end

  def logout
    current_user.try(:reset_token!)
    session[:token]  = nil
  end

  def require_logged_in!
    redirect_to root_url unless logged_in?
  end

  def require_logged_out!
    redirect_to user_url(current_user) if logged_in?
  end
end
