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

# Create main categories and their subcategories
makeup = Category.create!(name: 'Makeup')
skin_care = Category.create!(name: 'Skin Care')
hair_care = Category.create!(name: 'Hair Care')

makeup_subcategories = Category.create!([
                                          { name: 'Lipsticks', parent_id: makeup.id },
                                          { name: 'Foundations', parent_id: makeup.id },
                                          { name: 'Mascaras', parent_id: makeup.id }
                                        ])

skin_care_subcategories = Category.create!([
                                             { name: 'Moisturizers', parent_id: skin_care.id },
                                             { name: 'Cleansers', parent_id: skin_care.id },
                                             { name: 'Serums', parent_id: skin_care.id }
                                           ])

hair_care_subcategories = Category.create!([
                                             { name: 'Shampoos', parent_id: hair_care.id },
                                             { name: 'Conditioners', parent_id: hair_care.id },
                                             { name: 'Hair Masks', parent_id: hair_care.id }
                                           ])

# Create a default user (assuming you're using Devise for authentication)
user = User.create!(
  username: 'testuser',
  email: 'test@example.com',
  password: 'password',
  password_confirmation: 'password'
)

# Create some products assigned to specific subcategories
products = Product.create!([
                             { name: 'Lipstick', description: 'A bright red lipstick.', brand: 'La Roche-Posay', price: 19.99, stock: 50, category_id: makeup_subcategories[0].id, image: images[0] },
                             { name: 'Moisturizer', description: 'Hydrating face moisturizer.', brand: 'Nivea', price: 29.99, stock: 30, category_id: skin_care_subcategories[0].id, image: images[1] },
                             { name: 'Shampoo', description: 'Nourishing shampoo for dry hair.', brand: 'Dove', price: 12.99, stock: 100, category_id: hair_care_subcategories[0].id, image: images[2] },
                           # Add more products here, referencing appropriate subcategory IDs...
                           ])

# Create some comments for the products
Comment.create!([
                  { content: 'Great product! Highly recommend.', product: products[0], user: user },
                  { content: 'Really helped my skin stay hydrated.', product: products[1], user: user },
                  { content: 'My hair feels amazing after using this shampoo!', product: products[2], user: user }
                ])

puts "Seed data successfully created!"
