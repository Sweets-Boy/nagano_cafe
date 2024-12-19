class Address < ApplicationRecord

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end
  
  belongs_to :customer

  validates :postal_code, presence: true, length: { is: 7 }, numericality: { only_integer: true }
  validates :address, presence: true
  validates :name, presence: true
end
