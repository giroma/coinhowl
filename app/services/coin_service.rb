require_relative './../ws_clients/bittrex_client.rb'

class CoinService
  #code
  def self.summary
    #bittrex coin summary
    return BittrexClient.summary
  end

  def self.logo_urls
    return BittrexClient.coin_images
  end
end
