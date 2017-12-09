require_relative './../ws_clients/coin_row.rb'
require 'httparty'

class BittrexClient
  @@base_url = "https://bittrex.com/api/v1.1/public/"

  def self.summary
    response = HTTParty.get(@@base_url + "getmarketsummaries")
    response_body = JSON.parse(response.body)
    response_only_btc = response_body["result"].select {|coin|
      coin["MarketName"].include?("BTC-")}

    coin_rows = []
    response_only_btc.each do |coin|
      remap_name(coin)
      coin_row = CoinRow.new
      coin_row.name = coin["MarketName"]
      coin_row.symbol = symbol_for(coin_row.name)
      coin_row.volume = number_with_precision(coin["BaseVolume"], precision: 8)
      coin_row.bid = number_with_precision(coin["Bid"], precision: 8)
      coin_row.ask = number_with_precision(coin["Ask"], precision: 8)
      coin_row.pct_change = percentage_change(coin["Last"], coin["PrevDay"])
      coin_row.last_price = number_with_precision(coin["Last"], precision: 8)
      coin_row.high_24hr = number_with_precision(coin["High"], precision: 8)
      coin_row.low_24hr = number_with_precision(coin["Low"], precision: 8)
      coin_row.prev_day = number_with_precision(coin["PrevDay"], precision: 8)
      coin_row.added = Date.parse(coin["Created"])
      coin_rows << coin_row
    end
    return coin_rows
  end

  def self.ext_data(all_rows)
    response = HTTParty.get(@@base_url + "getmarkets")
    response_body = JSON.parse(response.body)
    response_images = response_body["result"].select {|coin|
      coin["MarketName"].include?("BTC-")}

    # prefill the ext_data hash with ALL symbol names and nil data
    ext_data = {}
    all_rows.each do |coin|
      ext_data[coin.symbol] = {
        image_url: "https://cdn.browshot.com/static/images/not-found.png",
        full_name: "N/A"
      }
    end

    # look for ext data for each symbol name and fill when available
    response_images.each do |ext|
      remap_name(ext)
      coin_ext = ext_data[symbol_for(ext["MarketName"])]
      logo_url = ext["LogoUrl"]
      full_name = ext["MarketCurrencyLong"]

      if (logo_url != nil)
        coin_ext[:image_url] = logo_url
      end

      if (full_name != nil)
        coin_ext[:full_name] = full_name
      end
    end

    return ext_data
  end

  def self.symbol_for(coin_name)
    return coin_name.slice(4..-1)
  end

  def self.percentage_change(last_price, prev_day)
    pct_change = number_with_precision((( last_price - prev_day)/prev_day )*100, precision: 2)
    return pct_change
  end

  def self.remap_name(element)
    if element["MarketName"] == "BTC-BCC"
      element["MarketName"] = "BTC-BCH"
    end
  end
end
