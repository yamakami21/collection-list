class UsersController < ApplicationController
  
  def show
    @user =User.find(params[:id])
    @items =@user.items
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Plaction!"
      redirect_to @user # ここを修正
    else
      render 'new'
    end
  end
  
  def followings
    @followings = @user.following_users
  end
  
  def followers
    @followers = @user.follower_users
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
