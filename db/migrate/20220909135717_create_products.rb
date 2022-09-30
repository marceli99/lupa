class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.references :category, null: false, foreign_key: true
      t.decimal :price, precision: 7, scale: 2

      t.timestamps
    end
  end
end
