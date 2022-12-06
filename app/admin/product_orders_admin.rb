Trestle.resource(:product_orders, model: ProductOrder) do
  build_instance do |attrs, params|
    raise Exception unless params[:order_id].present? || params[:product_order].present?

    if params[:product_order].present?
      ProductOrder
    else
      ProductOrder.new({'product_id' => 0, 'quantity' => 0, 'order_id' => params[:order_id]})
    end
  end

  controller do
    def create
      order = Order.find(params[:product_order][:order_id])
      product = Product.find(params[:product_order][:product_id])

      order.products ||= []
      order.products.append(
        {
          'id' => product.id,
          'quantity' => params[:product_order][:quantity].to_i,
          'name' => product.name,
          'description' => product.description,
          'price' => params[:product_order][:quantity].to_f * product.price
        }
      )
      order.save!

      redirect_to edit_orders_admin_path(order)
    end

    def destroy
      order = Order.find(params[:id])

      return redirect_to edit_orders_admin_path(order) unless order.products.kind_of?(Array)

      order.products.reject! { |p| p['id'] == params[:product_id].to_i }
      order.save!

      redirect_to edit_orders_admin_path(order)
    end

    def delete
      binding.pry
    end
  end

  form do |product_order|
    product_order = ProductOrder.new({'product_id' => 0, 'quantity' => 0, 'order_id': params[:order_id]})
    self.object = product_order
    collection_select :order_id, Order.where(id: product_order.order_id), :id, :customer_name#, disabled: true
    # static_field :order_id, product_order.order_id
    collection_select :product_id, Product.all, :id, :name
    number_field :quantity

    # row do
    #   col { datetime_field :updated_at }
    #   col { datetime_field :created_at }
    # end
  end

  params do |params|
    params.require(:product_order).permit(:order_id, :product_id, :quantity)
  end
end
