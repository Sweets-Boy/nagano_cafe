class Item < ApplicationRecord

  belongs_to :genre

  has_one_attached :image

  validates :genre_id, presence: true
  validates :name, presence: true
  validates :introduction, presence: true, length: { maximum:150 }
  validates :price, presence:true
  validates :is_active, inclusion: {in: [true, false]}

end
