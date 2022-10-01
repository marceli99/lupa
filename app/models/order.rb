class Order < ApplicationRecord
  validates_presence_of :customer_name, :customer_phone, :customer_email, :delivery_method, :delivery_time, :payment_method, :products

  validates :payment_method, inclusion: { in: %w(blik_payment card_payment cash_payment) }

  enum status: { waiting_for_payment: 0, payment_rejected: 1, waiting_for_approval: 2, rejected: 3, in_preparation: 4, in_delivery: 5, done: 6 }
end
