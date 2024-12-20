class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    status = params[:order][:status]
  
    case status
    when "入金待ち", "入金確認"
      if @order.update(order_params)
        if status == "入金確認"
          @order.order_details.update_all(making_status: "製作待ち")
          flash[:notice] = '注文ステータスが更新されました。製作ステータスが製作待ちになりました。'
        else
          flash[:notice] = '注文ステータスが更新されました。'
        end
        redirect_to admin_order_path(@order)
      else
        flash[:alert] = '注文ステータスの更新に失敗しました。'
        redirect_to admin_order_path(@order)
      end
    when "製作中"
      flash[:alert] = 'こちらは手動で変えられません。製作ステータスが更新されるまでお待ちください。'
      redirect_to admin_order_path(@order)
    when "発送準備中"
      flash[:alert] = 'こちらは手動で変えられません。製作ステータスが全て製作完了になるまでお待ちください。'
      redirect_to admin_order_path(@order)
    when "発送済み"
      if @order.order_details.all? { |order_detail| order_detail.making_status == "製作完了" }
        if @order.update(order_params)
          flash[:notice] = '注文ステータスが更新されました。発送済みになりました。'
        else
          flash[:alert] = '注文ステータスの更新に失敗しました。'
        end
        redirect_to admin_order_path(@order)
      else
        flash[:alert] = '製作ステータスが全て製作完了になるまでお待ちください。'
        redirect_to admin_order_path(@order)
      end
    else
      flash[:alert] = '注文ステータスの更新に失敗しました。'
      redirect_to admin_order_path(@order)
    end
  end


  private

  def order_params
    params.require(:order).permit(:status)
  end
  
end
