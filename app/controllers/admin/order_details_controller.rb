class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order

    making_statuses = ["着手不可", "製作待ち"]
    if making_statuses.include?(params[:order_detail][:making_status])
      redirect_to admin_order_path(@order), alert: 'こちらは手動で変えられません。'
      return
    end

    if @order_detail.update(order_detail_params)
      making_status = params[:order_detail][:making_status]
      case making_status
      when "製作中"
        if @order.status == "製作中"
          redirect_to admin_order_path(@order), notice: '製作ステータスが製作中に更新されました。'
        else
          if @order.update(status: "製作中")
            redirect_to admin_order_path(@order), notice: '製作ステータスが製作中に更新されました。注文ステータスが製作中になりました。'
          else
            redirect_to admin_order_path(@order), alert: '注文ステータスの更新に失敗しました。'
          end
        end
      when "製作完了"
        if @order.order_details.all? { |order_detail| order_detail.making_status == "製作完了" }
          if @order.update(status: "発送準備中")
            redirect_to admin_order_path(@order), notice: '製作ステータスは、全て製作完了になりました。注文ステータスが発送準備中になりました。'
          else
            redirect_to admin_order_path(@order), alert: '注文ステータスの更新に失敗しました。'
          end
        else
          redirect_to admin_order_path(@order), notice: '製作が製作完了に更新されましたが、すべての製作は完了しておりません。'
        end
      end
    else
      rredirect_to admin_order_path(@order), alert: '製作ステータスの更新に失敗しました。'
    end
  end


  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end