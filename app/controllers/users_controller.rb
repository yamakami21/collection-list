class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :edit, :update, :followings, :followers, :likings]
  
  def show
    @items =@user.items.page(params[:page]).per(10).order(created_at: :desc)
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
  
  def edit

  end
  
  def update
    if @user.update(user_params)
      flash[:success] =  "更新しました！"
      redirect_to user_path
    else
      render 'edit'
    end
  end
  
  def followings
    @followings = @user.following_users
  end
  
  def followers
    @followers = @user.follower_users
  end
  def likings
    @likings = @user.liked_items
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
