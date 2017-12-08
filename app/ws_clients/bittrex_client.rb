require 'coin_row.rb'
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
      coin_row.name = element["MarketName"]
      coin_row.symbol = element["MarketName"].slice(4..-1)
      coin_row.volume = element["BaseVolume"]
      coin_row.pct_change = element[""]# Math
      coin_row.last_price = element["Last"]
      coin_row.high_24hr = element["High"]
      coin_row.low_24hr = element["Low"]
      coin_row.added = element["Created"]
      coin_rows << coin_row
    end
    return coin_rows
  end
end
