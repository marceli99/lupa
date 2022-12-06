module OrdersHelper
  def get_products_from_json(json_data)
    ids = json_data.map do |product_data|
      product_data['id']
    end

    Product.where(id: ids)
  end
end
