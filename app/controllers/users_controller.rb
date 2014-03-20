class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login(@user)
      redirect_to root_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end

    def show
      @user = User.find(params[:id])
    else
      redirect_to user_url(current_user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :species)
  end
end
