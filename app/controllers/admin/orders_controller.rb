class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @order=Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order_details = @order.order_details
    if @order.status == "confirmation"
      @order_details.update_all(making_status: "pending")
      ## ①注文ステータスが「入金確認」とき、製作ステータスを全て「製作待ち」に更新する
    end
    redirect_to admin_order_path(@order)
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end

end
