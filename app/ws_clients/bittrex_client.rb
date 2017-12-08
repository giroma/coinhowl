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
      coin_row.volume = coin["BaseVolume"]
      coin_row.pct_change = coin[""]# Math
      coin_row.last_price = coin["Last"]
      coin_row.high_24hr = coin["High"]
      coin_row.low_24hr = coin["Low"]
      coin_row.added = coin["Created"]
      coin_rows << coin_row
    end
    return coin_rows
  end
end
