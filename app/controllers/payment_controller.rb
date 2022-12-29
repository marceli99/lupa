class PaymentController < ApplicationController
  def show
    if order.payment_method == 'cash_payment'
      order.update!(status: 'waiting_for_approval')

      redirect_to root_path
    end

    order
  end

  def accept
    order.update!(status: 'waiting_for_approval')

    redirect_to root_path
  end

  def reject
    order.update!(status: 'rejected', rejection_reason: 'The payment was rejected.')

    redirect_to root_path
  end

  private

  def order
    @order ||= Order.find(params[:id])
  end
end
