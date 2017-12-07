require 'spec_helper'
require 'capybara/rspec'
require "rails_helper"


feature 'Alerts', %q{
  As a user I shoul be able to login, follow a coin and
  create one alert
} do
  let(:user) { create(:random_user) }
  let(:following) { create(:random_following, user_id: user.id) }
  let(:following2) { create(:random_following, user_id: user.id) }
  scenario 'User log in' do
    login(user)
    expect(page).to have_content "BITCOIN MARKETS"
  end

end
