require "rails_helper"
require 'spec_helper'

RSpec.describe Alert, type: :model do
  context 'validation tests' do
    let(:user) { create(:random_user) }
    let(:following) { create(:following, user_id: user.id) }
    let(:alert) { build(:alert, following_id: following.id) }
    it "ensures alert can't be empty" do
      alert.price_above = nil
      alert.price_below = nil
      alert.percent = nil
      expect(alert.save).to eq(false)
    end

    it "ensures alert can be saved" do
      expect(alert.save).to eq(true)
    end


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
