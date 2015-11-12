class LikesController < ApplicationController
    
    def create
        @item = Item.find(params[:item_id])
        current_user.like(@item)
    end
    def destroy
        @item = Item.find(params[:item_id])
        current_user.unlike(@item)
    end
end
