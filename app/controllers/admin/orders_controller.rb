class Admin::OrdersController < ApplicationController
  def show
    @order=Order.find(params[:id])
  end
  
  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: params[:making_status])
    @order.update(order_params)
    if @order.status == "confirmation"
      @order_details.update_all(making_status: 1) 
      ## ①注文ステータスが「入金確認」とき、製作ステータスを全て「製作待ち」に更新する
    end
    redirect_to admin_order_path(@order)
  end
  
  private
  def order_params
    params.require(:order).permit(:status)
  end
    
end
