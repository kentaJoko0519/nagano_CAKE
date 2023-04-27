class Public::OrdersController < ApplicationController
  def new
    @order=Order.new
  end

  def confirm
    address_select = params[:order][:address_select]
    if address_select == "0"
      @order=Order.new(order_params)
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif address_select == "1"
      @order = Order.new(order_params)
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif address_select == "2"
      @order=Order.new(order_params)
    end
    @cart_items = current_customer.cart_items
    @order.shipping_cost = "800"
    @order.total_payment = @order.shipping_cost + @cart_items.sum(&:subtotal)
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @cart_items = current_customer.cart_items.all
    @order.save
    @cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.order_id = @order.id
      @order_details.item_id = cart_item.item.id
      @order_details.price = cart_item.item.price
      @order_details.amount = cart_item.amount
      @order_details.save!
    end
    current_customer.cart_items.destroy_all
    redirect_to complete_path
  end

  def index
    @orders = current_customer.orders
    @cart_items = current_customer.cart_items
  end

  def show
    @order = Order.find(params[:id])
    @cart_items = current_customer.cart_items
  end

    private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end
