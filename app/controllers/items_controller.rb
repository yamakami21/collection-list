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
  
  def destroy
    @item =current_user.items.find_by(id: params[:id])
    return redirect_to root_url if @item.nil?
    @item.destroy
    flash[:success] = "投稿を削除しました。"
    redirect_to request.referrer || root_url
  end
  
  private
  def item_params
    params.require(:item).permit(:name, :description, :price, :image)
  end
end
