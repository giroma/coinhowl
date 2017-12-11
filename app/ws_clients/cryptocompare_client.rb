require_relative './../ws_clients/coin_row.rb'
require_relative './../ws_clients/bittrex_client.rb'
require 'httparty'

class CryptoCompare
  @@base_url = "https://www.cryptocompare.com/api/data/"

  def self.cc_coin_list(all_rows)
    request = HTTParty.get(@@base_url + "coinlist/")
    response = JSON.parse(request.body)
    data = response["Data"]
    # prefill the cc_images_url hash with ALL symbol names and nil data
    cc_images_url = Hash.new
    all_rows.each do |coin|
      remap_name(coin.symbol)
      cc_images_url[coin.symbol] = {
        image_url: "https://cdn.browshot.com/static/images/not-found.png",
        full_name: "N/A"
      }
    end
  end

  def self.remap_name(element, data)
    base_image_url = 'https://www.cryptocompare.com'
    # Add images from Cryptocompare api call to the hash, replacing the ones that exist
      if element == 'BCC'
        cc_images_url['BCC'] = {
          image_url: base_image_url + data['BCH']["ImageUrl"],
          full_name: data['BCH']["CoinName"]
        }
      elsif element == 'GBG'
        cc_images_url['GBG'] = {
          image_url: base_image_url + data['GOLOS']["ImageUrl"],
          full_name: data['GOLOS']["CoinName"]
        }
      else
        cc_images_url[element] = {
          image_url: base_image_url + data[element]["ImageUrl"],
          full_name: data[element]["CoinName"]
        }
      end
    return cc_images_url
  end

  def self.get_chart_data_by_minute(symbol, limit)
    data_by_minute = HTTParty.get("https://min-api.cryptocompare.com/data/histominute?fsym=#{symbol}&limit=#{limit}&tsym=BTC&aggregate=3&e=Bittrex&allData=true")
    data_by_minute_result = JSON.parse(data_by_minute.body)
    data_by_minute_result = data_by_minute_result["Data"]

    data_by_minute_result.each do |element|
      element["date"] = Time.at(element["time"]).to_s
    end
    return data_by_minute_result
  end
end
