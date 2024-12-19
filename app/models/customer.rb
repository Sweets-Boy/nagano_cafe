class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy

  def full_name
    self.last_name + " " + self.first_name
  end
  def full_name_kana
    self.last_name_kana + " " + self.first_name_kana
  end

  # 退会済みかチェックするメソッド
  def active_for_authentication?
    super && self.is_active
  end
  
  has_many :addresses, dependent: :destroy
  
end
