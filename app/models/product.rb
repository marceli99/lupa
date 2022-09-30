class Product < ApplicationRecord
  acts_as_paranoid
  has_one_attached :image

  belongs_to :category
  has_many :product_orders
  has_many :orders, through: :product_orders

  has_many :orderables
  has_many :carts, through: :orderables

  validates :image, presence: true
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0, less_than: BigDecimal(10**5) }
end
