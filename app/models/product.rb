class Product < ApplicationRecord
  belongs_to :category
  has_many :invoice_products
  has_many :invoices, through: :invoice_products
  validates :product_description, :product_img, :product_name, :product_price, presence: true
  validates :product_name, numericality: true

  def self.ransackable_associations(auth_object = nil)
    [ "category" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "category_id", "category_name", "created_at", "id", "id_value", "product_description", "product_img", "product_name", "product_price", "updated_at" ]
  end
end
