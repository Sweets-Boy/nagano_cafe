class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :item


  def subtotal
    ((item.price * 1.1).to_i) * amount
  end

end
