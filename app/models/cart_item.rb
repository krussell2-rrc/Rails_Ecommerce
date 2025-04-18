class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def subtotal
    product.product_price * quantity
  end
end
