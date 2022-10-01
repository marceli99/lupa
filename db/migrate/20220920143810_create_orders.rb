class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, id: :uuid do |t|
      # Entered by user
      t.text :customer_name, null: false
      t.text :customer_phone, null: false
      t.text :customer_email, null: false
      t.text :delivery_method, null: false
      t.text :delivery_time, null: false
      t.text :delivery_street
      t.text :delivery_house_number
      t.text :delivery_city
      t.text :payment_method, null: false

      # Other fields
      t.json :products, null: false
      t.integer :status, default: 0
      t.datetime :estimated_delivery_date
      t.text :rejection_reason
      t.timestamps
    end
  end
end
