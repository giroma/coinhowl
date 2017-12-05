require "rails_helper"
require 'spec_helper'

RSpec.describe Following, type: :model do
  context 'validation tests' do
    let(:user) { create(:random_user) }
    let(:following) { build(:following) }
    it "ensures following coin name can't be empty" do
      following.user_id = user.id
      following.coin_name = nil
      expect(following.save).to eq(false)
    end

    it "ensures following user_id can't be empty" do
      following.user_id = nil
      expect(following.save).to eq(false)
    end

    it "ensures following can be saved" do
      following.user_id = user.id
      expect(following.save).to eq(true)
    end
  end
end
