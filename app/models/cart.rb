class Cart < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  has_many :orderables, dependent: :destroy
  has_many :products, through: :orderables

  def total
    orderables.to_a.sum { |orderable| orderable.total }
  end
end
