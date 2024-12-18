
class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def create
    @order = current_customer.orders.build(order_params)
    @cart_items = current_customer.cart_items.includes(:item)
    if @order.save
      @cart_items.each do |cart_item|
        @order.order_details.create(
          item_id: cart_item.item_id,
          amount: cart_item.amount,
          price: cart_item.subtotal
        )
      end
      @cart_items.destroy_all
      redirect_to thanks_pubilc_orders_path
    else
      render :confirm_order_path
    end
  end

  def thanks
  end

  def index
    @orders = current_customer.orders.includes(order_details: :item)
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_details = @order.order_details.includes(:item)
  end


  private
 
   def order_params
     params.require(:order).permit(:post_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
   end

end
