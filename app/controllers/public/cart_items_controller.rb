class Public::CartItemsController < ApplicationController

  def index
    @cart_items = current_customer.cart_items
  end

  def create

    unless customer_signed_in?
      redirect_to new_customer_session_path, notice: 'ログインが必要です'
      return
    end

    cart_item = current_customer.cart_items.find_by(item_id: cart_item_params[:item_id])

    if cart_item_params[:amount].nil? || cart_item_params[:amount].to_i <= 0
      flash[:notice] = '個数を正しく入力してください'
      redirect_back fallback_location: item_path(params[:cart_item][:item_id])
      return
    end


    if cart_item
      cart_item.amount += cart_item_params[:amount].to_i
      cart_item.save
    else
      cart_item = current_customer.cart_items.new(cart_item_params)
      cart_item.save
    end
    redirect_to cart_items_path, notice: '商品をカートに追加しました'
  end

  def update
    cart_item = current_customer.cart_items.find(params[:id])
    if cart_item.update(cart_item_params)
      redirect_to cart_items_path, notice:'数量を変更しました'
    else
      redirect_to cart_items_path, alert: '数量の更新に失敗しました'
    end
  end

  def destroy
    cart_item = current_customer.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path, notice: '商品を削除しました'
  end

  def destroy_all
    cart_items = current_customer.cart_items
    cart_items.destroy_all
    redirect_to cart_items_path, notice: 'カートを空にしました'
  end



  private
    def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
    end

end
