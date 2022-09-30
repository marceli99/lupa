class CartController < ApplicationController
  before_action :initialize_cart

  def add
    product = Product.find(params[:id])
    current_orderable = @cart.orderables.find_by(product_id: product.id)

    if current_orderable
      current_orderable.update(quantity: current_orderable.quantity + 1)
    else
      @cart.orderables.create!(product: product, quantity: 1)
    end

    render_cart
  end

  def remove
    Orderable.find(params[:id]).destroy!

    render_cart
  end

  def increase_count
    orderable = Orderable.find(params[:id])
    orderable.update!(quantity: orderable.quantity + 1)

    render_cart
  end

  def decrease_count
    orderable = Orderable.find(params[:id])
    if orderable.quantity == 1
      orderable.destroy!
    else
      orderable.update!(quantity: orderable.quantity - 1)
    end

    render_cart
  end

  def checkout
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('cart', partial: 'cart/checkout', locals: { cart: @cart })
      end
    end
  end

  def show
    render_cart
  end

  private

  def render_cart
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('cart', partial: 'cart/cart', locals: { cart: @cart })
      end
    end
  end
end
