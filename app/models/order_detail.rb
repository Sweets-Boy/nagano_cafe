class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  enum making_status: { 着手不可: 0, 製作待ち: 1, 製作中: 2, 製作完了: 3, }





  #enum making_status: { not_started: 0, pending: 1, in_progress: 2, completed: 3, }
end
