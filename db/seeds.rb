# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(username: 'michelle', email: 'michelle@gmail.com', password: '123',
    password_confirmation: '123')
User.create(username: 'horacio', email: 'horacio@gmail.com', password: '123',
        password_confirmation: '123')
User.create(username: 'ari', email: 'ari@gmail.com', password: '123',
        password_confirmation: '123')

10.times do
  following = Following.create!(
              user_id: rand(1..3),
              coin_name: ['BTC','ETH', 'BCH', 'XRP', 'LTC'].sample
            )
end
20.times do
  alerts = Alert.create!(
              price_above: rand(10533.7395700..10533.7395762),
              price_below: rand(10533.7395600..10533.7395700),
              state: 'Active',
              following_id: rand(1..10)
            )
end
