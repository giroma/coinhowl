require 'action_view'
include ActionView::Helpers::NumberHelper

FactoryBot.define do
  factory :alert do
    price_above { (rand(0.0001..0.0301)).round(8) }
    price_below { (rand(0.0001..0.0301)).round(8) }
    percent { (rand(0.01..100)).round(2) }
    state "Active"
  end
end
  # Alert schema
    # t.decimal "price_above"
    # t.decimal "price_below"
    # t.string "state"
    # t.bigint "following_id"
    # t.datetime "created_at", null: false
    # t.datetime "updated_at", null: false
    # t.decimal "percent"
    # t.index ["following_id"], name: "index_alerts_on_following_id"
