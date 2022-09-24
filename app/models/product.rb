class Product < ApplicationRecord
  acts_as_paranoid
  belongs_to :category
  has_many :product_orders
  has_many :orders, through: :product_orders
end
