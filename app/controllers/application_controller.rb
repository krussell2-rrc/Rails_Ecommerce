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

  protected

  # Send AdminUser to ActiveAdmin; normal users to products (or stored location if present)
  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_root_path          # /admin
    else
      stored_location_for(resource) || products_path
    end
  end

  # Runs for Devise::Registrations (normal users). ActiveAdmin doesn't sign up via UI.
  def after_sign_up_path_for(resource)
    products_path
  end

  # Separate sign-out destinations for admin vs normal users
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin_user
      new_admin_user_session_path  # /admin/login
    else
      new_user_session_path        # /users/sign_in
    end
  end
end
