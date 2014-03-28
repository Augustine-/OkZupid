PROFILE_PIX = {
  chicken: "chicken.gif",
  kangaroo: "kangaroo.gif",
  monkey: "monkey.gif",
  tiger: "tiger2.gif",
  bear: "bear.jpg",
  cat: "cat.jpg",
  dinosaur: "dinosaur.jpg",
  dog: "dog.jpg",
  dolphin: "dolphin.jpg",
  duck: "duck.jpg",
  gorilla: "gorilla.jpg",
  hawk: "hawk.jpg",
  horse: "horse.jpg",
  lion: "lion.jpg",
  lizard: "lizard.jpg",
  moose: "moose.jpg",
  mouse: "mouse.jpg",
  owl: "owl.jpg",
  rabbit: "rabbit.jpg",
  seagull: "seagull.jpg",
  seal: "seal.jpg",
  snake: "snake.jpg",
  turtle: "turtle.jpg",
  whale: "whale.jpg",
  penguin: "penguin.jpg",
  raccoon: "raccoon.gif"
}

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :find_post_by_prompt, :profile_pic
  
  def find_post_by_prompt(prompt)
    User.find(params[:id]).posts.find_by(prompt: prompt)
  end

  def current_user
    return nil unless session[:token]
    @current_user ||= User.find_by(token: session[:token])
  end
  
  def profile_pic(user)
    PROFILE_PIX[user.species.downcase.to_sym]
  end

  def logged_in?
    !!current_user
  end

  def profile_id
    params[:id]
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
