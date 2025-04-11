class Category < ApplicationRecord
  has_many :product

  def to_s
    category_name
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "category_name", "created_at", "id", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "product" ]
  end
end
