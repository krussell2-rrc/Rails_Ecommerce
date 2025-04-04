class Category < ApplicationRecord
  has_many :product

  def to_s
    category_name
  end
end
