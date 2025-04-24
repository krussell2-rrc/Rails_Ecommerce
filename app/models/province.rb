class Province < ApplicationRecord
  validates :province_code, :gst_rate, :pst_rate, :hst_rate, presence: true
  validates :gst_rate, :pst_rate, :hst_rate, numericality: true
  validates :province_code, length: { maximum: 2 }
end
