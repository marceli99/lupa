User.create!(email: "admin@example.com", password: "password")

main = Category.create!(name: 'Main dishes')
soup = Category.create!(name: 'Soups')
drink = Category.create!(name: 'Drinks')

product = Product.new(name: 'Meat burger', description: 'A lot of meat', category: main, price: 9.99)
product.image.attach(io: File.open(Rails.root.join('app/assets/images/hamburger.jpg')), filename: 'hamburger.jpg')
product.save(validate: false)

product = Product.new(name: 'Double Meat burger', description: 'A lot of meat', category: main, price: 17.99)
product.image.attach(io: File.open(Rails.root.join('app/assets/images/double_hamburger.jpg')), filename: 'double_hamburger.jpg')
product.save(validate: false)

product = Product.new(name: 'Margherita', description: 'Just a pizza', category: main, price: 9.99)
product.image.attach(io: File.open(Rails.root.join('app/assets/images/pizza.jpg')), filename: 'pizza.jpg')
product.save(validate: false)

product = Product.new(name: 'Fries', description: 'Potato fries', category: main, price: 1.99)
product.image.attach(io: File.open(Rails.root.join('app/assets/images/fries.jpg')), filename: 'fries.jpg')
product.save(validate: false)

product = Product.new(name: 'Tomato soup', description: 'Red tomato soup', category: soup, price: 2.99)
product.image.attach(io: File.open(Rails.root.join('app/assets/images/tomato_soup.jpg')), filename: 'tomato_soup.jpg')
product.save(validate: false)

product = Product.new(name: 'Ramen', description: 'Ramen soup', category: soup, price: 4.99)
product.image.attach(io: File.open(Rails.root.join('app/assets/images/ramen.jpg')), filename: 'ramen.jpg')
product.save(validate: false)

product = Product.new(name: 'Green soup', description: 'Green vegetable soup', category: soup, price: 1.99)
product.image.attach(io: File.open(Rails.root.join('app/assets/images/green_soup.jpg')), filename: 'green_soup.jpg')
product.save(validate: false)

product = Product.new(name: 'Cola', description: 'Just a cola', category: drink, price: 0.99)
product.image.attach(io: File.open(Rails.root.join('app/assets/images/cola.jpg')), filename: 'cola.jpg')
product.save(validate: false)

product = Product.new(name: 'Tea with ginger', description: 'Tea', category: drink, price: 1.99)
product.image.attach(io: File.open(Rails.root.join('app/assets/images/tea.jpg')), filename: 'tea.jpg')
product.save(validate: false)

product = Product.new(name: 'Smoothie', description: 'Green smoothie', category: drink, price: 1.99)
product.image.attach(io: File.open(Rails.root.join('app/assets/images/smoothie.jpg')), filename: 'smoothie.jpg')
product.save(validate: false)

7.times do |day|
  OpenHour.create!(
    day_of_week: day + 1,
    open_time: Time.parse('07:00:00'),
    close_time: Time.parse('23:00:00'),
  )
end

puts 'Seeded database!'
