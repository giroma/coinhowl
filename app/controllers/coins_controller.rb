class CoinsController < ApplicationController

  before_action :call_coin_market_cap
  before_action :call_bittrex
  before_action :call_cryptocompare_api

  def index
    @response = HTTParty.get('https://api.coinmarketcap.com/v1/ticker/?convert=CAD&limit=50')
    @result = JSON.parse(@response.body)
  end

  def show
    @coin_symbol = params[:id]
    if current_user
      @following = Following.find_by(user_id: current_user.id, coin_name: @coin_symbol)
      @is_following = @following.present? ? true : false
      @alert = Alert.new
    end
    get_chart_data_by_minute

    @response_only_btc.each do |coin|
      if coin["MarketName"] == "BTC-BCC"
        coin["MarketName"] = 'BTC-BCH'
        @coin_last = coin["Last"]
        @coin_base_volume = coin["BaseVolume"]
        @coin_bid = coin["Bid"]
        @coin_ask = coin["Ask"]
        @coin_high = coin["High"]
        @coin_low = coin["Low"]
        @last_updated = coin["TimeStamp"]
      elsif coin["MarketName"] == "BTC-#{@coin_symbol}"
        @coin_last = coin["Last"]
        @coin_base_volume = coin["BaseVolume"]
        @coin_bid = coin["Bid"]
        @coin_ask = coin["Ask"]
        @coin_high = coin["High"]
        @coin_low = coin["Low"]
        @last_updated = coin["TimeStamp"]
        @local_time = Time.at(DateTime.parse(@last_updated).to_i)
      end
    end
  end

  def get_chart_data_by_minute
    @data_by_minute = HTTParty.get("https://min-api.cryptocompare.com/data/histominute?fsym=#{@coin_symbol}&limit=100&tsym=BTC&aggregate=3&e=Bittrex&allData=true")
    @data_by_minute_result = JSON.parse(@data_by_minute.body)
    @data_by_minute_result = @data_by_minute_result["Data"]

# {"time"=>1510660800, "close"=>0.0499, "high"=>0.05, "low"=>0.04969, "open"=>0.04991, "volumefrom"=>219.73999999999998, "volumeto"=>10.97}
    @data_by_minute_result.each do |element|
      element["date"] = Time.at(element["time"]).to_s
    end

  end

end
