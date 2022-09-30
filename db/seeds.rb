# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#

User.create!(email: "admin@example.com", password: "password")

main_dish = Category.create!(name: 'Main dishes')
pizza = Category.create!(name: 'Pizza')
soup = Category.create!(name: 'Soups')
pasta = Category.create!(name: 'Pasta')
drink = Category.create!(name: 'Drinks')

products = [
  Product.new(name: 'Margherita', description: 'Lorem ipsum', category: pizza, price: 12.99),
  Product.new(name: 'Neapolitan', description: 'Lorem ipsum', category: pizza, price: 14.99),
  Product.new(name: 'Pepperoni', description: 'Lorem ipsum', category: pizza, price: 13.99),
  Product.new(name: 'Sicilian', description: 'Lorem ipsum', category: pizza, price: 16.99),
  Product.new(name: 'Duo Formaggi', description: 'Lorem ipsum', category: pizza, price: 19.99),
  Product.new(name: 'Quattro Formaggi', description: 'Lorem ipsum', category: pizza, price: 21.99),
  Product.new(name: 'Salmon', description: 'Lorem ipsum', category: main_dish, price: 22.99),
  Product.new(name: 'Vegan Meat Balls', description: 'Lorem ipsum', category: main_dish, price: 22.99),
  Product.new(name: 'Breaded Cauliflower', description: 'Lorem ipsum', category: main_dish, price: 22.99),
  Product.new(name: 'Bread-crumbed Pork chop', description: 'Lorem ipsum', category: main_dish, price: 24.99),
  Product.new(name: 'Pad thai', description: 'Lorem ipsum', category: main_dish, price: 23.99),
  Product.new(name: 'Chickpea omelette', description: 'Lorem ipsum', category: main_dish, price: 23.99),
  Product.new(name: 'Borsch', description: 'Lorem ipsum', category: soup, price: 14.99),
  Product.new(name: 'Cucumber soup', description: 'Lorem ipsum', category: soup, price: 13.99),
  Product.new(name: 'Tomato soup', description: 'Lorem ipsum', category: soup, price: 13.99),
  Product.new(name: 'Chicken alfredo', description: 'Lorem ipsum', category: pasta, price: 18.99),
  Product.new(name: 'Pasta Alla Gricia', description: 'Lorem ipsum', category: pasta, price: 17.99),
  Product.new(name: 'Sheet-Pan Burrata Caprese Gnocchi', description: 'Lorem ipsum', category: pasta, price: 18.99),
  Product.new(name: 'Penne Alla Vodka', description: 'Lorem ipsum', category: pasta, price: 17.99),
  Product.new(name: 'Baked Ziti', description: 'Lorem ipsum', category: pasta, price: 19.99),
  Product.new(name: 'Puttanesca', description: 'Lorem ipsum', category: pasta, price: 18.99),
  Product.new(name: 'Water (250ml)', description: 'Lorem ipsum', category: drink, price: 1.99),
  Product.new(name: 'Coca Cola (250ml)', description: 'Lorem ipsum', category: drink, price: 3.99),
  Product.new(name: 'Sprite', description: 'Lorem ipsum', category: drink, price: 3.99),
]

products.each do |product|
  product.save(validate: false)
  product.image.attach(io: File.open(Rails.root.join('app/assets/images/vegan-pizza.jpg')), filename: 'vegan-pizza.jpg')
end
