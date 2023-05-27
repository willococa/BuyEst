FactoryBot.define do
  factory :admin do
    username { Faker::Internet.unique.username(specifier: 5..8) }
    email { Faker::Internet.unique.email }
    password { 'password' }
    password_confirmation { 'password' }
    role { 'admin' }
  end

  factory :sale do
    association :client

    transient do
      order { nil }
    end

    after(:build) do |sale, evaluator|
      if evaluator.order
        sale.order = evaluator.order
      end
    end
  end

  factory :order do
    status { :pending }
    checked_out { false }

    transient do
      sale { true }
    end

    after(:build) do |order, evaluator|
      if evaluator.sale
        order.sale = build(:sale, order: order)
      end
    end

    factory :order_with_items do
      after(:build) do |order|
        order.order_items << FactoryBot.build_list(:order_item, 2, order: order)
      end
    end
  end

  factory :client do
    email { "user_#{SecureRandom.hex(5)}@example.com" }
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
      unless creator.nil?
        version = product.versions.order(:created_at).first
        version.whodunnit = creator.id.to_s
        version.save!
      end
    end
  end

  factory :order_item do
    association :product, factory: :product
    association :order, factory: :order, strategy: :build_stubbed
  end

  factory :product_category do
    name { Faker::Commerce.unique.department(max: 2) }
    description { Faker::Lorem.sentence(word_count: 10) }
  end
end

