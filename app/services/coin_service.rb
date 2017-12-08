require_relative './../ws_clients/bittrex_client.rb'

class CoinService
  #code
  def self.summary
    #bittrex coin summary
    coin_summary = BittrexClient.summary

    return coin_summary
  end
end
