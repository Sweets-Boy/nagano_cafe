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
          price: cart_item.item.with_tax_price
        )
      end
      @cart_items.destroy_all
      redirect_to thanks_orders_path
    else
      render :new
    end
  end

  def confirm
    @order = Order.new(order_params)
    @order.shipping_cost = 800
    @cart_items = current_customer.cart_items.includes(:item)
    case params[:order][:address_select]
    when "customer_address"
      @order.postal_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name
    when "address_list"
      address = current_customer.addresses.find_by(id: params[:order][:address_id])
      if address.nil?
        flash[:error] = "※登録してある配送先住所から選択してください。"
        render :new and return
      else
        @order.postal_code = address.postal_code
        @order.address = address.address
        @order.name = address.name
      end
    when "new_address"
      if new_address_params?
        @order.postal_code = params[:order][:postal_code]
        @order.address = params[:order][:address]
        @order.name = params[:order][:name]
      else
        flash[:error] = "新しいお届け先の情報が不足しています。"
        render :new and return
      end
    else
      flash[:error] = "住所の選択に問題があります。再度確認してください。"
      render :new
    end
  end

  def thanks
  end

  def index
    @orders = current_customer.orders.includes(order_details: :item)
    @orders = Order.order(created_at: :desc)
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_details = @order.order_details.includes(:item)
  end


  private
 
   def order_params
     params.require(:order).permit(:payment_method, :postal_code, :address, :name, :shipping_cost, :total_payment, :status)
   end

   def new_address_params?
    params[:order][:postal_code].present? &&
    params[:order][:address].present? &&
    params[:order][:name].present?
  end

end
