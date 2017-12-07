class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

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

  def top_5_coins
    call_bittrex
    @top_5_coins = @response_only_btc.map do |element|
      [ element["MarketName"],
       {
         original: element,
         change: ((element["Last"] - element["PrevDay"])/element["PrevDay"]) * 100
       }
      ]
    end.to_h
    @carousel_position = ["#one!","#two!","#three!","#four!","#five!"]
    @top_5_coins = @top_5_coins.sort_by {|coin, values| values[:change]}[-5..-1].reverse
  end

  def call_cryptocompare_api
    @cryptocompare = HTTParty.get('https://www.cryptocompare.com/api/data/coinlist')
    @cryptocompare_result = JSON.parse(@cryptocompare.body)
    @cryptocompare_result = @cryptocompare_result["Data"]
    # @base_cc_url = @cryptocompare_result["BaseImageUrl"]
    # coin_image = @cryptocompare_result[cc_symbol]["ImageUrl"]
    # @coin_image_url = "#{base_cc_url}+#{coin_image}"
  end

  def cc_image_url
    @top_5_cc_symbol = @top_5_coins.map {|coin| coin[0].remove("BTC-")}
    # @top_5_cc_symbol = @top_5_cc_symbol)
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
