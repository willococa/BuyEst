# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

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
