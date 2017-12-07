require 'spec_helper'
require 'capybara/rspec'
require "rails_helper"


feature 'Followings', %q{
  User login and follow a coin
} do
  let!(:user) { create(:random_user) }
  # let!(:parameters) { :user_id => user.id, :coin_name => 'BCH' }
  # scenario 'User log in' do
  #   login(user)
  #   expect(page).to have_content "BITCOIN MARKETS"
  # end
  # scenario 'User visits a coin' do
  #   login(user)
  #   visit('/coins/BCH')
  # expect(page).to have_content "BCH"
  # end
  scenario 'User follows a coin' do
    login(user)
    visit('/coins/BCH')
    find("a#follow-coin", :text => "Follow").click
    visit( '/following/BCH', { :params => { :user_id => user.id, :coin_name => 'BCH' } })
    visit('/coins/BCH')
    # expect(page).to have_css('a#unfollow-coin', visible: true)
    save_and_open_page
  end

end
