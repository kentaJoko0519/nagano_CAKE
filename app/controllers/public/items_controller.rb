class Public::ItemsController < ApplicationController
  def index
    @items=Item.page(params[:page])
  end

  def show
    @item=Item.find(params[:id])
    # cart_itemのコントローラーに受け渡す
    @cart_item=CartItem.new
    # cart_itemのコントローラーに顧客のID（customer_id）を送るため
    @customer=current_customer
  end
  
  private
  
  def item_params
    params.require(:item).permit(:item_image, :name, :genre_id,:introduction,:price,:is_active)
  end
  
end
