class CartItemsController < ApplicationController
  def create
    product = Product.find_by(id: params[:product_id])
    @cart = current_cart

    item = @cart.cart_items.find_by(product_id: params[:product_id])

    if item
      item.quantity += 1
      item.save
    else
      @cart.cart_items.create(product: product, quantity: 1)
    end
    redirect_to product_path(product), alert: "Item added to cart!"
  end
end
