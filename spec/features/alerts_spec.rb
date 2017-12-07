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
  scenario 'User visits portfolio' do
    login(user)
    follow_coin(user, following)
    visit('/following')
      expect(page).to have_css('ul.collapsible')
  end
  scenario 'User creates alert' do
    login(user)
    follow_coin(user, following)
    visit('/following')
    find("ul.collapsible").click
    click_on('Add Alert')
    fill_in('alert[percent]', :with => '1.1')
    click_on('Create Alert')
    expect(page).to have_css('tr.alerts-info')
  end
  scenario 'User deletes alert', js: true do
    login(user)
    follow_coin(user, following)
    visit('/following')
    find("ul.collapsible").click
    click_on('Add Alert')
    fill_in('alert[percent]', :with => '1.1')
    click_on('Create Alert')
    find("ul.collapsible").click
    click_link('Delete')
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_no_content("1.1"), :driver => :webkit
  end
end
