
FactoryBot.define do
  factory :admin do    
    username {Faker::Internet.unique.username(specifier: 5..8)}
    email {Faker::Internet.unique.email}
    password {'password'}
    password_confirmation {'password'}
    role {'admin'}
  end

  factory :order do
    status { :pending }
    checked_out { false }
    # Define any other necessary attributes

    association :client
    after(:build) do |order|
      order.order_items << FactoryBot.build_list(:order_item, 2, order: order)
    end  
  end
  
  factory :client do
    # Use Faker to generate fake data
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }
    password_confirmation { password }
  end
  
  factory :product do
    name { Faker::Commerce.product_name }
    cost { Faker::Commerce.price(range: 10..100) }
    description { Faker::Lorem.sentence(word_count: 10) }
    product_categories { [create(:product_category)] } # Assuming you have a product category factory
    images { [Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'image.jpg'), 'image/jpg')] }
    transient do
      creator { nil }
    end
    after(:create) do |product, evaluator|
      creator = evaluator.creator
      version = product.versions.order(:created_at).first
      version.whodunnit = creator.id.to_s
      version.save!
    end
  end
  factory :order_item do
    association :product, factory: :product
    association :order
  end
  factory :product_category do
    name { Faker::Commerce.unique.department(max: 2) }
    description { Faker::Lorem.sentence(word_count: 10) }
  end
end
  