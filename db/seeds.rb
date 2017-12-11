# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(username: 'michelle', email: 'michelle@gmail.com', password: '123',
    password_confirmation: '123', avatar_url: "https://api.adorable.io/avatars/60/michelle.png")
User.create!(username: 'horacio', email: 'horacio@gmail.com', password: '123',
        password_confirmation: '123', avatar_url: "https://api.adorable.io/avatars/60/horacio.png")
User.create!(username: 'ari', email: 'ari@gmail.com', password: '123',
        password_confirmation: '123', avatar_url: "https://api.adorable.io/avatars/60/ari.png")

10.times do
  following = Following.create!(
              user_id: rand(1..3),
              coin_name: ['BCH','ETH', 'TIX', 'XRP', 'LTC'].sample
            )
end

40.times do
  alerts = Alert.create!(
              price_above: rand(0.02..0.03).round(8),
              price_below: rand(0.01..0.02).round(8),
              percent: rand(1.1..20.1).round(2),
              state: 'Active',
              following_id: rand(1..10)
            )
end
