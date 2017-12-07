module  UserHelper

  def login(a)
    visit root_path
    click_link 'Log In'
    fill_in 'email', with: a.email
    fill_in 'password', with: a.password
    click_button 'Login'
  end

  def logout(a)
    visit root_path
    click_link 'Logout'
  end

  def follow_coin(user, coin)
    visit following_index_path(:user_id => user.id, :coin_name => coin.coin_name)
  end

  def delete_alert(follow, alert)
    visit following_alert_path(follow, alert)
  end
  
end
