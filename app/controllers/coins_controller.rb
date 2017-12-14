class CoinsController < ApplicationController
  def index
    @coin_summary = CoinService.summary
    @ext_data = CoinService.ext_data(@coin_summary)
    @cc_coin_list = CoinService.cc_coin_list(@coin_summary)

    # Data needed for carousel top 5
    sorted_summary = @coin_summary.sort_by { |coin| coin.pct_change.to_i }
    @top_5_coins = sorted_summary[-5..-1].reverse
    @carousel_position = ["#one!","#two!","#three!","#four!","#five!"]
  end

  def show
    coin_symbol = params[:id]
    coin_summary = CoinService.summary
    @coin = CoinService.get_coin(coin_symbol)
    @image_url = CoinService.ext_data(coin_summary)[coin_symbol][:image_url]
    @cc_coin_list = CoinService.cc_coin_list(@coin)
    if current_user
      @following = Following.find_by(user_id: current_user.id, coin_name: coin_symbol)
      @is_following = @following.present? ? true : false
      @alert = Alert.new
    end
    if coin_symbol == 'BCC'
      @data_by_minute_result = get_chart_data_by_minute('BCH', 100)
    else
      @data_by_minute_result = get_chart_data_by_minute(coin_symbol, 100)
    end
  end

  def get_chart_data_by_minute(symbol, limit)
    data_by_minute = HTTParty.get("https://min-api.cryptocompare.com/data/histominute?fsym=#{symbol}&limit=#{limit}&tsym=BTC&aggregate=3&e=Bittrex&allData=true")
    data_by_minute_result = JSON.parse(data_by_minute.body)
    data_by_minute_result = data_by_minute_result["Data"]

    data_by_minute_result.each do |element|
      element["date"] = Time.at(element["time"]).to_s
    end
    return data_by_minute_result
  end
end
