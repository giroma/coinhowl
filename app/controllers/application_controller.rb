class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # before_action :call_coin_market_cap
  # before_action :call_bittrex
  # before_action :call_cryptocompare_api

  def send_confirmation_sms
    client = Twilio::REST::Client.new(ENV['TWILIO_ID'], ENV['TWILIO_TOKEN'])

    client.api.account.messages.create(
      from: ENV['PHONE_NUMBER'],
      to: "+1#{current_user.phone}",
      body: "Your alert has been triggered"
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
    base_cc_url = @cryptocompare_result["BaseImageUrl"]
    # coin_image = @cryptocompare_result[cc_symbol]["ImageUrl"]
    # @coin_image_url = "#{base_cc_url}+#{coin_image}"
  end
  helper_method :current_user
  helper_method :ensure_logged_in
  helper_method :ensure_ownership

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # def ensure_logged_in
  #   if !current_user
  #     flash[:alert] = "Please log in"
  #     redirect_to root_url
  #   end
  # end
  #
  # def ensure_ownership
  #   if current_user.id != @project.user_id
  #     flash[:alert] = 'Not authorized owner'
  #     redirect_to root_url
  #   end
  # end

end
