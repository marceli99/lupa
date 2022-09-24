class AddCountToProductOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :product_orders, :count, :integer
  end
end
