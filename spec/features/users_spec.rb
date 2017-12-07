require 'spec_helper'
require 'capybara/rspec'
require "rails_helper"


feature 'User Management', %q{
  As the site owner
  I want to provide an user management
  so that I can protect functions and grant access based on roles
} do

  background do
    @user = create(:random_user)
  end
  scenario 'User log in' do
# activate(@user)
login(@user)
expect(page).to have_content "BITCOIN MARKETS"
end
end
