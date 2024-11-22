# Clear existing data
Comment.destroy_all
Product.destroy_all
Category.destroy_all
User.destroy_all

images = [
  File.open(Rails.root.join('app', 'assets', 'images', 'product1.png')),
  File.open(Rails.root.join('app', 'assets', 'images', 'product2.jpg')),
  File.open(Rails.root.join('app', 'assets', 'images', 'product3.webp')),
  File.open(Rails.root.join('app', 'assets', 'images', 'product4.jpg')),
  File.open(Rails.root.join('app', 'assets', 'images', 'product5.jpg')),
  File.open(Rails.root.join('app', 'assets', 'images', 'product6.jpg')),
  File.open(Rails.root.join('app', 'assets', 'images', 'product7.jpg')),
  File.open(Rails.root.join('app', 'assets', 'images', 'product8.jpg')),
  File.open(Rails.root.join('app', 'assets', 'images', 'product9.jpg')),
  File.open(Rails.root.join('app', 'assets', 'images', 'product10.jpeg')),
  File.open(Rails.root.join('app', 'assets', 'images', 'product11.webp')),
  File.open(Rails.root.join('app', 'assets', 'images', 'product12.png')),
  File.open(Rails.root.join('app', 'assets', 'images', 'product13.webp')),
  File.open(Rails.root.join('app', 'assets', 'images', 'product14.webp')),
  File.open(Rails.root.join('app', 'assets', 'images', 'product15.jpg'))
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
                             { name: 'Foundation', description: 'Full-coverage liquid foundation.', brand: 'Maybelline', price: 24.99, stock: 60, category_id: makeup_subcategories[1].id, image: images[3] },
                             { name: 'Serum', description: 'Vitamin C face serum.', brand: 'The Ordinary', price: 39.99, stock: 25, category_id: skin_care_subcategories[2].id, image: images[4] },
                             { name: 'Conditioner', description: 'Silky smooth conditioner.', brand: 'Herbal Essences', price: 10.99, stock: 90, category_id: hair_care_subcategories[1].id, image: images[5] },
                             { name: 'Mascara', description: 'Volumizing black mascara.', brand: 'L\'Oreal', price: 15.99, stock: 40, category_id: makeup_subcategories[2].id, image: images[6] },
                             { name: 'Cleanser', description: 'Gentle foaming cleanser.', brand: 'Cetaphil', price: 22.99, stock: 35, category_id: skin_care_subcategories[1].id, image: images[7] },
                             { name: 'Hair Mask', description: 'Deep conditioning mask.', brand: 'Pantene', price: 14.99, stock: 45, category_id: hair_care_subcategories[2].id, image: images[8] },
                             { name: 'Blush', description: 'Natural pink blush.', brand: 'NYX', price: 16.99, stock: 20, category_id: makeup_subcategories[0].id, image: images[9] },
                             { name: 'Night Cream', description: 'Repairing night cream.', brand: 'Olay', price: 42.99, stock: 15, category_id: skin_care_subcategories[0].id, image: images[10] },
                             { name: 'Hair Oil', description: 'Argan oil for smooth hair.', brand: 'Moroccanoil', price: 29.99, stock: 50, category_id: hair_care_subcategories[1].id, image: images[11] },
                             { name: 'Lip Balm', description: 'Hydrating lip balm.', brand: 'Burt\'s Bees', price: 5.99, stock: 200, category_id: makeup_subcategories[0].id, image: images[12] },
                             { name: 'Exfoliator', description: 'Gentle facial exfoliator.', brand: 'Neutrogena', price: 20.99, stock: 25, category_id: skin_care_subcategories[1].id, image: images[13] },
                             { name: 'Dry Shampoo', description: 'Quick refresh dry shampoo.', brand: 'Batiste', price: 8.99, stock: 100, category_id: hair_care_subcategories[0].id, image: images[14] }
                           ])
# Create some comments for the products
Comment.create!([
                  { content: 'Great product! Highly recommend.', product: products[0], user: user },
                  { content: 'Really helped my skin stay hydrated.', product: products[1], user: user },
                  { content: 'My hair feels amazing after using this shampoo!', product: products[2], user: user }
                ])

puts "Seed data successfully created!"
