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
  # scenario 'User deletes alert' do
  #   login(user)
  #   follow_coin(user, following)
  #   visit('/following')
  #   find("ul.collapsible").click
  #   click_on('Add Alert')
  #   fill_in('alert[percent]', :with => '1.1')
  #   click_on('Create Alert')
  #   click_on('Delete', format: :js)
  #   # alert_id_partial = find('a.delete_alert')['href']
  #   # alert_id = "#{alert_id_partial.sub(/[a-z].*\/|$/im)}"
  #   # delete_alert(following.id, alert_id)
  #   # end
  #   # save_and_open_page
  #   # expect(page).to has_no_css('tr.alerts-info')
  #   expect(page).to have_no_content("1.1")
  # end
end
