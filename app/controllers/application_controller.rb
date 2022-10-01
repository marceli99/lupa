class ApplicationController < ActionController::Base
  protected

  def initialize_cart
    @cart ||= Cart.find_or_create_by!(id: session[:cart_id])
    session[:cart_id] = @cart.id
  end

  def clear_cart
    @cart ||= Cart.find_or_create_by!(id: session[:cart_id])
    @cart.destroy
  end
end
