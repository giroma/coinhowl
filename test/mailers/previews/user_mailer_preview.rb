# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def alert_email
    UserMailer.alert_email(User.first , Alert.first)
  end
  def welcome_email
    UserMailer.welcome_email(User.first)
  end
  def alert_email2
    UserMailer.alert_email2(User.first)
  end
end
