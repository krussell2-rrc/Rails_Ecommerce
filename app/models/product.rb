class Product < ApplicationRecord
  belongs_to :category

  def self.ransackable_associations(auth_object = nil)
    [ "category" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "category_id", "category_name", "created_at", "id", "id_value", "product_description", "product_img", "product_name", "product_price", "updated_at" ]
  end
end
