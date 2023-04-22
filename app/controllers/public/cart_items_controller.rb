class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
  end

  def create
    @cart_items = current_customer.cart_items
    @cart_item = CartItem.new(cart_item_params)
    # cart_itemの中のitem_idを探す
    cart_item = @cart_items.find_by(item_id: params[:cart_item][:item_id])
    # cart_itemの中のitem_idを探して同じitem_idがあれば13行に、無ければ15行に
    if cart_item
      # cart_itemの数（amount）を追加
      cart_item.update(amount: @cart_item.amount+cart_item.amount)
    else
      # 新しく商品を追加
      @cart_item.save
    end
    render :index
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

    private

  def cart_item_params
    params.require(:cart_item).permit(:amount,:item_id,:customer_id)
  end

end
