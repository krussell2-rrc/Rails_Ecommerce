class CartController < ApplicationController
  def show
    @cart = current_cart
  end

  def add_item
  end
end
