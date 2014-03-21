class UsersController < ApplicationController
  before_action :require_logged_in!, only: [:show]
  before_action :require_logged_out!, only: [:new]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end

    def show
      @user = User.find(params[:id])
      redirect_to user_url(current_user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :species)
  end
end
