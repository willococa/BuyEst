
FactoryBot.define do
    factory :order do
      status { :pending }
      checked_out { false }
      # Define any other necessary attributes
  
      association :client
    end
  
    factory :client do
      # Use Faker to generate fake data
      email { Faker::Internet.email }
      password { Faker::Internet.password(min_length: 8) }
      password_confirmation { password }
    end
  end
  