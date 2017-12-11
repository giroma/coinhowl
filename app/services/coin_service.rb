require_relative './../ws_clients/bittrex_client.rb'
require_relative './../ws_clients/cryptocompare_client.rb'

class CoinService
  @@cache_key_ext_data = "ext_data"
  @@cache_key_summary = "coin_summary"
  @@cache_key_cc_coin_list = "cc_coin_list"
  @@cache_expiry_summary = 15 # seconds
  @@cache_expiry_ext_data = 24 # hours
  @@cache_expiry_cc_coin_list = 24 # hours

  def self.summary
    # bittrex coin summary
    return Rails.cache.fetch(@@cache_key_summary, :expires_in => @@cache_expiry_summary.seconds) do
      BittrexClient.summary
    end
  end

  def self.ext_data(all_rows)
    # try getting cached version
    return Rails.cache.fetch(@@cache_key_ext_data, :expires_in => @@cache_expiry_ext_data.hours) do
      BittrexClient.ext_data(all_rows)
    end
  end

  def self.cc_coin_list(all_rows)
    # try getting cached version
    return Rails.cache.fetch(@@cache_key_cc_coin_list, :expires_in => @@cache_expiry_cc_coin_list.seconds) do
      CryptoCompare.cc_coin_list(all_rows)
    end
  end

  def self.get_coin(symbol)
    full_summary = summary
    return full_summary.detect { |e| e.symbol == symbol }
  end
end
