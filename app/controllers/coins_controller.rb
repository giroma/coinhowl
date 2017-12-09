require_relative './../services/coin_service.rb'

class CoinsController < ApplicationController
  def index
    @coin_summary = CoinService.summary
    @ext_data = CoinService.ext_data(@coin_summary)

    # Data needed for carousel top 5
    sorted_summary = @coin_summary.sort_by { |coin| coin.pct_change.to_i }
    @top_5_coins = sorted_summary[-5..-1].reverse
    @carousel_position = ["#one!","#two!","#three!","#four!","#five!"]
  end

  def show
    # call_bittrex
    coin_symbol = params[:id]
    coin_summary = CoinService.summary
    @coin = CoinService.get_coin(coin_symbol)
    @image_url = CoinService.ext_data(coin_summary)[coin_symbol][:image_url]

    if current_user
      @following = Following.find_by(user_id: current_user.id, coin_name: coin_symbol)
      @is_following = @following.present? ? true : false
      @alert = Alert.new
    end

    @data_by_minute_result = get_chart_data_by_minute(coin_symbol, 100)

    # @bch = @response_only_btc.select {|coin| coin["MarketName"].include?('BTC-BCC')}
    # @bch = @bch[0]
    #
    # @response_only_btc.each do |coin|
    #   if @coin_symbol == "BCH"
    #     # coin["MarketName"] = 'BTC-BCC'
    #     @coin_last = @bch["Last"]
    #     @coin_base_volume = @bch["BaseVolume"]
    #     @coin_bid = @bch["Bid"]
    #     @coin_ask = @bch["Ask"]
    #     @coin_high = @bch["High"]
    #     @coin_low = @bch["Low"]
    #     @prev_day = @bch["PrevDay"]
    #     # @last_updated = @bch["TimeStamp"]
    #     # @local_time = Time.at(DateTime.parse(@last_updated).to_i)
    #   elsif coin["MarketName"] == "BTC-#{@coin_symbol}"
    #     @coin_last = coin["Last"]
    #     @coin_base_volume = coin["BaseVolume"]
    #     @coin_bid = coin["Bid"]
    #     @coin_ask = coin["Ask"]
    #     @coin_high = coin["High"]
    #     @coin_low = coin["Low"]
    #     @prev_day = coin["PrevDay"]
    #     # @last_updated = coin["TimeStamp"]
    #     # @local_time = Time.at(DateTime.parse(@last_updated).to_i)
    #   end
    # end
  end

  def get_chart_data_by_minute(symbol, limit)
    data_by_minute = HTTParty.get("https://min-api.cryptocompare.com/data/histominute?fsym=#{symbol}&limit=#{limit}&tsym=BTC&aggregate=3&e=Bittrex&allData=true")
    data_by_minute_result = JSON.parse(data_by_minute.body)
    data_by_minute_result = data_by_minute_result["Data"]

# {"time"=>1510660800, "close"=>0.0499, "high"=>0.05, "low"=>0.04969, "open"=>0.04991, "volumefrom"=>219.73999999999998, "volumeto"=>10.97}
    data_by_minute_result.each do |element|
      element["date"] = Time.at(element["time"]).to_s
    end
    return data_by_minute_result
  end
end
