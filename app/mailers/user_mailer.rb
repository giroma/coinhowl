class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url  = 'www.coinhowl.com'
    mail(to: @user.email, subject: 'Welcome to CoinHowl')
  end
  def alert_email_above(email, alert)
    @url  = 'www.coinhowl.com'
    mail(to: email, subject: "id #{alert.id} #{alert.following.coin_name} > #{alert.price_above}")
  end
  def alert_email_below(email, alert)
    @url  = 'www.coinhowl.com'
    mail(to: email, subject: "id #{alert.id} #{alert.following.coin_name} < #{alert.price_above}")
  end
  def alert_email_percent(email, alert)
    @url  = 'www.coinhowl.com'
    mail(to: email, subject: "id #{alert.id} #{alert.following.coin_name} price has changed over #{alert.percent}%")
  end
end
