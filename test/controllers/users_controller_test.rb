require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  test 'User cant be saved when empty' do

    user = User.new

    assert_not(user.save, 'User saved empty')
  end
end
