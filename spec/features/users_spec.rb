require 'spec_helper'
require 'capybara/rspec'
require "rails_helper"


feature 'User Management', %q{
  Create User and test Login
} do

  background do
    @user = create(:random_user)
  end
  scenario 'User log in' do
  login(@user)
  expect(page).to have_content "BITCOIN MARKETS"
  end
end

feature 'User Management', %q{
  Create User, login and test Logout
} do

  background do
    @user = create(:random_user)
  end
  scenario 'User log in' do
  login(@user)
  expect(page).to have_content "BITCOIN MARKETS"
  logout(@user)
  expect(page).to have_content "Logged out!"
  end
end
