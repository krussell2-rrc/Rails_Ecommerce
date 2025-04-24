class Order < ApplicationRecord
  validates :order_status, :order_tax, :quantity, :grand_total, presence: true
  validates :order_tax, :grand_total, :quantity, numericality: true
  belongs_to :customer
end
