class Customer < ApplicationRecord
  belongs_to :user
  validates :full_name, :phone_number, presence: true
  validates :phone_number, numericality: true
end
