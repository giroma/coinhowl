FactoryBot.define do
  factory :user do
    username "John Doe"
    email "johndoe@gmail.com"
    password "123"
    password_confirmation "123"
    phone "6479090000"
    email_alert true
    phone_alert true
    avatar_url "https://api.adorable.io/avatars/60/John_Doe.png"
  end

  factory :random_user, class: User do
    username { Faker::Name.name }
    email { Faker::Internet.email }
    password "123"
    password_confirmation "123"
    phone {rand.to_s[1..10]}
    email_alert Faker::Boolean.boolean(0.9)
    phone_alert Faker::Boolean.boolean(0.5)
    avatar_url {"https://api.adorable.io/avatars/60/#{username}.png"}
  end
end
