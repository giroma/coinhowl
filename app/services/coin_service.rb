require_relative './../ws_clients/bittrex_client.rb'

class CoinService
  #code
  def self.summary
    #bittrex coin summary
    return BittrexClient.summary
  end

  def self.ext_data(all_rows)
    return BittrexClient.ext_data(all_rows)
  end
end
