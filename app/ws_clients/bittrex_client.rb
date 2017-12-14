require_relative './../ws_clients/coin_row.rb'
require 'httparty'

class BittrexClient
  @@base_url = "https://bittrex.com/api/v1.1/public/"

  # gets the complete summary of BTC coins
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
      coin_row.volume = ActionController::Base.helpers.number_with_precision(coin["BaseVolume"], precision: 2)
      coin_row.bid = ActionController::Base.helpers.number_with_precision(coin["Bid"], precision: 8)
      coin_row.ask = ActionController::Base.helpers.number_with_precision(coin["Ask"], precision: 8)
      coin_row.pct_change = percentage_change(coin["Last"], coin["PrevDay"])
      coin_row.last_price = ActionController::Base.helpers.number_with_precision(coin["Last"], precision: 8)
      coin_row.high_24hr = ActionController::Base.helpers.number_with_precision(coin["High"], precision: 8)
      coin_row.low_24hr = ActionController::Base.helpers.number_with_precision(coin["Low"], precision: 8)
      coin_row.prev_day = ActionController::Base.helpers.number_with_precision(coin["PrevDay"], precision: 8)
      coin_row.added = Date.parse(coin["Created"])
      coin_rows << coin_row
    end
    return coin_rows
  end

  # gets all extended data (images and full name)
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

  # extracts symbol from market name
  def self.symbol_for(coin_name)
    return coin_name.slice(4..-1)
  end

  # math lol
  def self.percentage_change(last_price, prev_day)
    pct_change = ActionController::Base.helpers.number_with_precision((( last_price - prev_day)/prev_day )*100, precision: 2)
    return pct_change
  end

  # remaps name to correct market name
  def self.remap_name(element)
    if element["MarketName"] == "BTC-BCC"
      element["MarketName"] = "BTC-BCC"
    end
  end
end
