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
    click_link 'Log Out'
  end

  def activate(a)
    visit activate_path(:code => a.activation_code)
  end

end
