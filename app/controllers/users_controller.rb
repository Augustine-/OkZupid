class UsersController < ApplicationController
  before_action :require_logged_in!, only: [:show]
  before_action :require_logged_out!, only: [:new]
  def new
    @user = User.new
  end
  
  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      prof = Profile.create(user_id: @user.id)
      prof.generate_posts(prof.id)
      
      login(@user)
      redirect_to user_url(@user.id)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :password, :species)
  end
end
