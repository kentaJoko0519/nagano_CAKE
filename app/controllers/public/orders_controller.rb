class Public::OrdersController < ApplicationController
  def new
    @order=Order.new
    @address=Address.new
  end

  def comfirm
  end

  def complete
  end

  def index
  end

  def show
  end
  
  def create
  end
  
    private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end
  
end
