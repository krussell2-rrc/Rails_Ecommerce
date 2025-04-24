class Province < ApplicationRecord
  validates :province_code, :province_name, presence: true
  validates :gst_rate, :pst_rate, :hst_rate, numericality: true, allow_nil: true
  validates :province_code, length: { maximum: 2 }
end
