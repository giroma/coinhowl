require "rails_helper"
require 'spec_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    let(:user) { build(:random_user) }

    it "ensures username present" do
      user.username = nil
      expect(user.save).to eq(false)
    end

    it "ensures password can't be empty" do
      user.password = nil
      expect(user.save).to eq(false)
    end

    it "ensures password present and longer than 3 characters" do
      user.password = '123'
      expect(user.save).to eq(true)
    end

    it "ensures email present" do
      user.email = nil
      expect(user.save).to eq(false)
    end

    it "ensures can save user" do
      expect(user.save).to(eq(true))
    end
  end
end
