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
      cc_images_url[coin.symbol] = {
        image_url: "https://cdn.browshot.com/static/images/not-found.png",
        full_name: "N/A"
      }
    end
    base_image_url = 'https://www.cryptocompare.com'
    # Add images from Cryptocompare api call to the hash, replacing the ones that exist
    all_rows.each do | coin |
      if coin.symbol == 'BCC'
        cc_images_url['BCC'] = {
          image_url: base_image_url + data['BCH']["ImageUrl"],
          full_name: data['BCH']["CoinName"]
        }
      elsif coin.symbol == 'GBG'
        cc_images_url['GBG'] = {
          image_url: base_image_url + data['GOLOS']["ImageUrl"],
          full_name: data['GOLOS']["CoinName"]
        }
      else
        cc_images_url[coin.symbol] = {
          image_url: base_image_url + data[coin.symbol]["ImageUrl"],
          full_name: data[coin.symbol]["CoinName"]
        }
      end
    end
    return cc_images_url
  end
end
