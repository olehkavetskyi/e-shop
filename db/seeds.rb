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
                             { name: 'Lipstick', description: 'A bright red lipstick.', brand: 'La Roche-Posay', price: 19.99, stock: 50, category: categories[0], section: 'Lipsticks', image: images[0] },
                             { name: 'Moisturizer', description: 'Hydrating face moisturizer.', brand: 'Nivea', price: 29.99, stock: 30, category: categories[1], section: 'Moisturizers', image: images[1] },
                             { name: 'Shampoo', description: 'Nourishing shampoo for dry hair.', brand: 'Dove', price: 12.99, stock: 100, category: categories[2], section: 'Shampoos', image: images[2] },
                             { name: 'Foundation', description: 'Long-lasting liquid foundation.', brand: 'Maybelline', price: 14.99, stock: 75, category: categories[0], section: 'Foundations', image: images[3] },
                             { name: 'Body Lotion', description: 'Moisturizing body lotion.', brand: 'Aveeno', price: 10.99, stock: 60, category: categories[1], section: 'Moisturizers', image: images[4] },
                             { name: 'Hair Mask', description: 'Deep conditioning hair mask.', brand: 'OGX', price: 8.99, stock: 50, category: categories[2], section: 'Hair Masks', image: images[5] },
                             { name: 'Sunscreen', description: 'SPF 50 broad-spectrum sunscreen.', brand: 'Neutrogena', price: 15.99, stock: 40, category: categories[1], section: 'Moisturizers', image: images[6] },
                             { name: 'Face Wash', description: 'Gentle face cleanser.', brand: 'Cetaphil', price: 7.99, stock: 90, category: categories[1], section: 'Cleansers', image: images[7] },
                             { name: 'Mascara', description: 'Volumizing black mascara.', brand: 'L\'Oréal', price: 13.49, stock: 80, category: categories[0], section: 'Mascaras', image: images[8] },
                             { name: 'Conditioner', description: 'Smoothing hair conditioner.', brand: 'Pantene', price: 5.99, stock: 110, category: categories[2], section: 'Conditioners', image: images[9] },
                             { name: 'Eye Cream', description: 'Anti-aging eye cream.', brand: 'Olay', price: 24.99, stock: 35, category: categories[1], section: 'Serums', image: images[10] },
                             { name: 'Nail Polish', description: 'Glossy nude nail polish.', brand: 'Essie', price: 8.99, stock: 120, category: categories[0], section: 'Nail Products', image: images[11] },
                             { name: 'Hair Serum', description: 'Anti-frizz hair serum.', brand: 'Tresemmé', price: 11.99, stock: 50, category: categories[2], section: 'Serums', image: images[12] },
                             { name: 'Face Mask', description: 'Charcoal detox face mask.', brand: 'Garnier', price: 9.99, stock: 45, category: categories[1], section: 'Masks', image: images[13] },
                             { name: 'Eyeliner', description: 'Waterproof black eyeliner.', brand: 'Revlon', price: 6.49, stock: 65, category: categories[0], section: 'Eye Makeup', image: images[14] },
                             { name: 'Body Scrub', description: 'Exfoliating body scrub.', brand: 'St. Ives', price: 7.49, stock: 55, category: categories[1], section: 'Cleansers', image: images[15] },
                             { name: 'Hair Gel', description: 'Strong hold styling gel.', brand: 'Gatsby', price: 6.99, stock: 90, category: categories[2], section: 'Gels', image: images[16] },
                             { name: 'Face Toner', description: 'Refreshing toner for all skin types.', brand: 'Thayers', price: 10.99, stock: 70, category: categories[1], section: 'Toners', image: images[17] },
                             { name: 'Blush', description: 'Natural pink powder blush.', brand: 'MAC', price: 18.49, stock: 40, category: categories[0], section: 'Blushes', image: images[18] },
                             { name: 'Hair Spray', description: 'Flexible hold hairspray.', brand: 'Herbal Essences', price: 4.99, stock: 85, category: categories[2], section: 'Hairsprays', image: images[19] }
                           ])


# Create some comments for the products
Comment.create!([
                  { content: 'Great product! Highly recommend.', product: products[0], user: user },
                  { content: 'Really helped my skin stay hydrated.', product: products[1], user: user },
                  { content: 'My hair feels amazing after using this shampoo!', product: products[2], user: user }
                ])

puts "Seed data successfully created!"
