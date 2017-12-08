require_relative './../ws_clients/coin_row.rb'
require 'httparty'

class BittrexClient
  @@base_url = "https://bittrex.com/api/v1.1/public/"

  def self.summary
    response = HTTParty.get(@@base_url + "getmarketsummaries")
    response_only_btc = JSON.parse(response.body)
    response_only_btc = response_only_btc["result"].select {|coin| coin["MarketName"].include?("BTC-")}

    coin_rows = []
    response_only_btc.each do |coin|
      coin_row = CoinRow.new
      coin_row.name = coin["MarketName"]
      coin_row.symbol = coin["MarketName"].slice(4..-1)
      coin_row.volume = number_with_precision(coin["BaseVolume"], precision: 8)
      coin_row.pct_change = coin_row.percentage_change(coin["Last"], coin["PrevDay"])# Math
      coin_row.last_price = number_with_precision(coin["Last"], precision: 8)
      coin_row.high_24hr = number_with_precision(coin["High"], precision: 8)
      coin_row.low_24hr = number_with_precision(coin["Low"], precision: 8)
      coin_row.prev_day = number_with_precision(coin["PrevDay"], precision: 8)
      coin_row.added = Date.parse(coin["Created"])
      coin_rows << coin_row
    end
    return coin_rows
  end
end
