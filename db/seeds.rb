# db/seeds.rb

puts "Seeding sample users..."

# Clear any old records so we start fresh each time
User.destroy_all

# Create a few example users
User.create!([
  { username: "Osieku", password: "password123" },
  { username: "Brian", password: "secret123" },
  { username: "Charles", password: "12345678" }
])

puts "Done seeding users!"
