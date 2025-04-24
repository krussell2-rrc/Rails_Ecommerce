class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  validates :quantity, :price_at_order_time, :tax_at_order_time, :line_total, presence: true, numericality: true
end
