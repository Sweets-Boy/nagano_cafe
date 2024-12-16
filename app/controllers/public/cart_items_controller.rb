class Public::CartItemsController < ApplicationController

  def index
    @cart_items = current_customer.cart_items
  end

  def create
    cart_item = current_customer.cart_items.find_by(item_id: cart_item_params[:item_id])
    if cart_item
      cart_item.amount += cart_item_params[:amount].to_i
      cart_item.update(amount: cart_item.amount)
    else
      cart_item = current_customer.cart_items.new(cart_item_params)
      cart_item.save
    end
    redirect_to cart_items_path, notice: 'カートが更新されました'
  end

  def update
    cart_item = current_customer.cart_items.find(params[:id])
    if cart_item.update(cart_item_params)
      redirect_to cart_items_path, notice:'数量を変更しました'
    else
      @cart_items = current_customer.cart_items
      render :index, alert:'数量の変更に失敗しました'
    end
  end

  def destroy
    cart_item = current_customer.cart_items.find(params[:id])
    if cart_item.destroy
      redirect_to cart_items_path, notice:'商品を削除しました'
    else
      redirect_to cart_items_path, alert:'商品の削除に失敗しました'
    end
  end

  def destroy_all
    cart_items = current_customer.cart_items
    if cart_items.destroy_all
      redirect_to cart_items_path, notice:'商品を全て削除しました'
    else
      redirect_to cart_items_path, alert:'商品の全削除に失敗しました'
    end
  end



  private
    def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
    end

end
