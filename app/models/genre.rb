class Genre < ApplicationRecord

  has_many :items, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false, message: "はすでに存在しています" }
end
