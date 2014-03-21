class SessionsController < ApplicationController
  before_action :require_logged_out!, only: [:new, :create, :landing]
  before_action :require_logged_in!, only: [:destroy]

  def landing
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
    user_params[:username],
    user_params[:password]
    )

    if @user
      login(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Invalid Credentials"]
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :species)
  end
end
