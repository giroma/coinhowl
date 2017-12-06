require 'test_helper'
require "rails_helper"

RSpec.describe User, :type => :model do
  context "validation tests" do
    let(:user) {build(:user)}
    # let(:user) {create(:user)}
    it "ensures username present" do
      user.username = nil
      expect(user.save).to eq(false)
    end
  end
end
