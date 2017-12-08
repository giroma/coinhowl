require_relative './../services/coin_service.rb'

class CoinsController < ApplicationController
  before_action :call_coin_market_cap
  before_action :call_bittrex
  before_action :call_cryptocompare_api
  before_action :top_5_coins
  before_action :cc_image_url

  def index
    @coin_summary = CoinService.summary
    @logo_urls = CoinService.logo_urls
  end

  def show
    @coin_symbol = params[:id]
    if current_user
      @following = Following.find_by(user_id: current_user.id, coin_name: @coin_symbol)
      @is_following = @following.present? ? true : false
      @alert = Alert.new
    end

    get_chart_data_by_minute

    @bch = @response_only_btc.select {|coin| coin["MarketName"].include?('BTC-BCC')}
    @bch = @bch[0]

    @response_only_btc.each do |coin|
      if @coin_symbol == "BCH"
        # coin["MarketName"] = 'BTC-BCC'
        @coin_last = @bch["Last"]
        @coin_base_volume = @bch["BaseVolume"]
        @coin_bid = @bch["Bid"]
        @coin_ask = @bch["Ask"]
        @coin_high = @bch["High"]
        @coin_low = @bch["Low"]
        @prev_day = @bch["PrevDay"]
        # @last_updated = @bch["TimeStamp"]
        # @local_time = Time.at(DateTime.parse(@last_updated).to_i)
      elsif coin["MarketName"] == "BTC-#{@coin_symbol}"
        @coin_last = coin["Last"]
        @coin_base_volume = coin["BaseVolume"]
        @coin_bid = coin["Bid"]
        @coin_ask = coin["Ask"]
        @coin_high = coin["High"]
        @coin_low = coin["Low"]
        @prev_day = coin["PrevDay"]
        # @last_updated = coin["TimeStamp"]
        # @local_time = Time.at(DateTime.parse(@last_updated).to_i)
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
