class Orderable < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  delegate :name, :description, :price, to: :product

  def total
    product.price * quantity
  end

  def as_json(options = {})
    super(options).merge(
      {
        'name' => name,
        'description' => description,
        'price' => price.to_s
      }
    ).except('product_id', 'cart_id', 'created_at', 'updated_at')
  end
end
