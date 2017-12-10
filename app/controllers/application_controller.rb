require_relative '../services/coin_service'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def check_logged_in
    if current_user.nil?
      flash[:alert] = "You must be logged in to continue."
      redirect_to new_session_url
    end
  end

  def send_confirmation_sms
    client = Twilio::REST::Client.new(ENV['TWILIO_ID'], ENV['TWILIO_TOKEN'])

    client.api.account.messages.create(
      from: ENV['PHONE_NUMBER'],
      to: "+1#{current_user.phone}",
      body: "Coinhowl: Phone number linked!"
    )
  end

  def call_coin_market_cap
    @response = HTTParty.get('https://api.coinmarketcap.com/v1/ticker/?convert=CAD&limit=5')
    @result = JSON.parse(@response.body)
  end

  def call_bittrex
    response = HTTParty.get("https://bittrex.com/api/v1.1/public/getmarketsummaries")
    @response_only_btc = JSON.parse(response.body)
    @response_only_btc = @response_only_btc["result"].select {|coin| coin["MarketName"].include?("BTC-")}
  end

  def call_cryptocompare_api
    @cryptocompare = HTTParty.get('https://www.cryptocompare.com/api/data/coinlist')
    @cryptocompare_result = JSON.parse(@cryptocompare.body)
    @cryptocompare_result = @cryptocompare_result["Data"]
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
