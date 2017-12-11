require_relative '../services/coin_service'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :require_login  

  def send_confirmation_sms
    client = Twilio::REST::Client.new(ENV['TWILIO_ID'], ENV['TWILIO_TOKEN'])

    client.api.account.messages.create(
      from: ENV['PHONE_NUMBER'],
      to: "+1#{current_user.phone}",
      body: "Coinhowl: Phone number linked!"
    )
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    session[:user_id] != nil if current_user
  end

  def require_login
    if !logged_in?
      flash[:alert] = "You must log in first."
      redirect_to login_path, status: 200
    end
  end

end
