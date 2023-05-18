require 'faker'

# Create 4 Devise clients

4.times do |i|
    Client.create!(
      email: "client#{i+1}@example.com",
      password: 'password',
      password_confirmation: 'password'
      # Add additional fields as necessary
      # Example: name: "Client #{i+1}", age: 30, address: "123 Example St"
    )
  end
  
#   product categories
# Create Product Categories
5.times do
    ProductCategory.create!(
      name: Faker::Commerce.unique.department(max: 2),
      description: Faker::Lorem.sentence(word_count: 10)
    )
  end

# Array of sample image filenames
image_files = [
    'image1.jpg',
    'image2.jpg',
    'image3.jpg',
    'image4.jpg',
    'image5.jpg',
    'image6.jpg',
    'image7.jpg',
    'image8.jpg',
    'image9.jpg',
    'image10.jpg'
  ]
  
  # Method to generate a random number of images (1-4) for a product
  def generate_random_images(image_files)
    num_images = rand(1..4)
    image_files.sample(num_images)
  end
  
  # Create or update 10 products
  10.times do
    product_attributes = {
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.sentence(word_count: 40),
      cost: Faker::Commerce.price(range: 10.0..100.0),
      has_first_sale: false
    }
    
    product = Product.find_or_create_by(product_attributes)
    
    product.images.attach(
      generate_random_images(image_files).map do |image|
        {
          io: File.open(Rails.root.join('public/images', image)),
          filename: image
        }
      end
    )
     # Assign random categories to each product
  categories = ProductCategory.all.sample(rand(1..3))
  product.product_categories << categories
  end
  