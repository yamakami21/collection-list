class ItemsController < ApplicationController
  def new
    @item = current_user.items.build if logged_in?
  end
  
  def create
    @item = current_user.items.build(item_params)
    if @item.save
      flash[:success] = "投稿に成功しました"
      redirect_to root_path
    else
      render new_item_path
    end
  end
  
  private
  def item_params
    params.require(:item).permit(:name, :description, :price)
  end
end
