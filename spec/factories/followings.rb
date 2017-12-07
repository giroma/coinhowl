FactoryBot.define do
  factory :following do
    coin_name { 'BCH' }
  end

  factory :random_following, class: Following do
    coin_name { ['BCH','ETH', 'TIX', 'XRP', 'LTC'].sample }
  end
end


# Followings schema
  # t.bigint "user_id"
  # t.string "coin_name"
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false
  # t.index ["user_id"], name: "index_followings_on_user_id"
