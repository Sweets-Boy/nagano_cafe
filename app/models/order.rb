class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { 入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済み: 4}




  #enum status: { deposit_pending: 0, payment_confirmed: 1, in_making: 2, preparing_shipment: 3, shipped: 4 }
end
