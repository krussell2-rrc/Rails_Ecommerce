class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_cart
  def current_cart
    if session[:cart_id]
      Cart.find_by(id: session[:cart_id]) || create_new_cart
    else
      create_new_cart
    end
  end

  private

  def create_new_cart
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
