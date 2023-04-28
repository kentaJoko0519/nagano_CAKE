class OrderDetail < ApplicationRecord
  
  enum making_status: { not_possible: 0, pending: 1, making: 2, complete: 3 }
  
  belongs_to :order
  belongs_to :item
  
  def subtotal
    item.with_tax_price * amount
  end
  
end
