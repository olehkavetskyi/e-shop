# Clear existing data
Comment.destroy_all
Product.destroy_all
Category.destroy_all
User.destroy_all

images = [
  File.open(Rails.root.join('app', 'assets', 'images', 'product1.png')),
  File.open(Rails.root.join('app', 'assets', 'images', 'product2.jpg')),
  File.open(Rails.root.join('app', 'assets', 'images', 'product3.webp')),
]

# Create some categories
categories = Category.create!([
                                { name: 'Makeup' },
                                { name: 'Skin Care' },
                                { name: 'Hair Care' }
                              ])

# Create a default user (assuming you're using Devise for authentication)
user = User.create!(
  username: 'testuser',
  email: 'test@example.com',
  password: 'password',
  password_confirmation: 'password'
)

# Create some products
products = Product.create!([
                             { name: 'Lipstick', description: 'A bright red lipstick.', price: 19.99, stock: 50, category: categories[0], image: images[0] },
                             { name: 'Moisturizer', description: 'Hydrating face moisturizer.', price: 29.99, stock: 30, category: categories[1], image: images[1] },
                             { name: 'Shampoo', description: 'Nourishing shampoo for dry hair.', price: 12.99, stock: 100, category: categories[2], image: images[2] }
                           ])

# Create some comments for the products
Comment.create!([
                  { content: 'Great product! Highly recommend.', product: products[0], user: user },
                  { content: 'Really helped my skin stay hydrated.', product: products[1], user: user },
                  { content: 'My hair feels amazing after using this shampoo!', product: products[2], user: user }
                ])

puts "Seed data successfully created!"
