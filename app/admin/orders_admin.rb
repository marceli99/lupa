Trestle.resource(:orders) do
  menu do
    item :orders, icon: "fa fa-star"
  end

  table do
    column 'Customer', :customer_name
    column 'Phone', :customer_phone
    column 'Email', :customer_email
    column 'Delivery Address', :full_address
    column 'Payment method', :payment_method
    column 'Products', :formatted_product_names
    column 'Status', :status
  end

  form do |order|
    tab :order do
      text_field :customer_name
      text_field :customer_phone
      text_field :customer_email
      payment_methods = Order::PAYMENT_METHODS.map { |payment_method| [payment_method.humanize, payment_method] }
      select :payment_method, payment_methods
      text_field :delivery_city
      text_field :delivery_street
      text_field :delivery_house_number
    end

    tab :products, badge: order.products&.size || 0 do
      table order.products.try(:map) { |product_data| JsonObject.new(product_data) } || [] do
        column :id
        column :name
        column :description
        column :quantity, align: :center
        column :price, align: :center
        actions do |a|
          link_to 'Remove', product_orders_admin_path(self.form.object.id, product_id: a.instance.id), method: :delete
        end
      end

      concat admin_link_to("New Product", admin: :product_orders, action: :new, params: { order_id: order }, class: "btn btn-success")
    end
  end
end
