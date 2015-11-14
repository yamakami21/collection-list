class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @item = current_user.items.build
      @feed_items = current_user.feed_items.includes(:user).page(params[:page]).per(10).order(created_at: :desc)
    else
      redirect_to login_url
    end
  end
end
