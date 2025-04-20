class CartController < ApplicationController
  def show
    @cart = current_cart
    @address = Address.new
  end
end
