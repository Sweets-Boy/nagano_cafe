class Item < ApplicationRecord
  has_one_attached :image

  validates :name, presence: true
  validates :introduction, presence: true, length: { maxmun:150 }
  validates :price, presence:true

end
