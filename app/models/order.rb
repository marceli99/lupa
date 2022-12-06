class Order < ApplicationRecord
  PAYMENT_METHODS = %w[blik_payment card_payment cash_payment]

  validates_presence_of :customer_name, :customer_phone, :customer_email, :delivery_method, :delivery_time, :payment_method, :products
  validates :payment_method, inclusion: { in: PAYMENT_METHODS }

  enum status: { waiting_for_payment: 0, payment_rejected: 1, waiting_for_approval: 2, rejected: 3, in_preparation: 4, in_delivery: 5, done: 6 }

  scope :todays_orders, -> { where('DATE(created_at) = ?', DateTime.current.to_date) }

  before_update :broadcast_status, if: proc { status_was && status_changed? }

  def broadcast_status
    return unless status == 'waiting_for_approval'

    OrdersChannel.broadcast({ id: id, status: status })
  end

  def full_address
    "#{delivery_city}, #{delivery_street} #{delivery_house_number}"
  end

  def formatted_product_names
    products.map do |product|
      "#{product['quantity']}x #{product['name']} - #{(product['quantity'].to_i * product['price'].to_f).round(2)} PLN"
    end.join(', ')
  end

  def formatted_html_product_names
    products.map do |product|
      "#{product['quantity']}x #{product['name']}"
    end.join('<br>').html_safe
  end
end
