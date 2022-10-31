class OrdersController < ApplicationController
  layout 'order_layout', only: [:index, :create, :show]

  def index
    @orders = Order.todays_orders
  end

  def create
    if params[:delivery_method] == 'cash_payment'
      order = Order.create!(order_params.to_h.merge({ products: orderables_json, status: 'waiting_for_approval' }))
    else
      order = Order.create!(order_params.to_h.merge({ products: orderables_json }))
    end

    clear_cart
    redirect_to order_path(order)
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    # authenticate_user!

    Order.find(order_update_params[:id]).update!(status: order_update_params[:status])
  end

  def status
    render json: { status: Order.find(params[:id]).status }
  end

  def board_order
    render :partial => 'partials/table_order', locals: { order: Order.find(params[:id])}
  end

  private

  def orderables_json
    cart.orderables.as_json
  end

  def cart
    @cart ||= Cart.find(params[:cart_id])
  end

  def order_update_params
    params.permit(:id, :status)
  end

  def order_params
    params.permit(:customer_name, :customer_phone, :customer_email, :delivery_method,
                  :delivery_time, :delivery_street, :delivery_house_number, :delivery_city,
                  :payment_method)
  end
end
