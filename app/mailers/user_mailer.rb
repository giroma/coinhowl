class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url  = 'www.coinhowl.com'
    mail(to: @user.email, subject: 'Welcome to CoinHowl')
  end
  def alert_email(user, alert)
    @user = user
    @alert = alert
    @url  = 'www.coinhowl.com'
    mail(to: @user.email, subject: "#{alert.following.coin_name} above #{alert.price_above}")
  end
end
