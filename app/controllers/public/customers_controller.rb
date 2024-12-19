class Public::CustomersController < ApplicationController

  before_action :authenticate_customer!
  before_action :authenticate_customer!

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def unsubscribe
  
  end

  def withdrawal
    @customer = current_customer
    @customer.update(is_active: false) # 退会フラグを更新
    reset_session # セッション情報を削除
    redirect_to root_path, notice: '退会処理が完了しました。'
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: '顧客情報が更新されました。'
    else
      flash.now[:alert] = '更新に失敗しました。入力内容を確認してください。'
      render :edit
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :email, :last_name_kana, :first_name_kana, :post_code, :address, :telephone_number)
  end

  def set_customer
    @customer = current_customer
  end

end
