require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  empty_user = User.new
  user = User.create(username: 'Test User', email: 'test@gmail.com', password: '123', password_confirmation: '123', phone: '1234567890', phone_alert: true, email_alert: true, avatar_url: '')

  test 'User cant be saved when empty' do
    assert_not(empty_user.save, 'User saved empty')
  end

  test 'User logged in can follow a coin' do

    coin_symbol = 'LTC'
    following = Following.new(user_id: user, coin_name: coin_symbol)
    assert_equal(following.save, true)
  end
end
