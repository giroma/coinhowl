require_relative './../ws_clients/bittrex_client.rb'
require_relative './../ws_clients/cryptocompare_client.rb'

class CoinService
  @@cache_key_ext_data = "ext_data"
  @@cache_key_summary = "coin_summary"
  @@cache_key_cc_coin_list = "cc_coin_list"
  @@btc_to_dollar_euro_price = 'btc_to_dollar_euro_price'
  @@cache_expiry_summary = 15 # seconds
  @@cache_expiry_ext_data = 24 # hours
  @@cache_expiry_cc_coin_list = 24 # hours
  @@cache_expiry_btc_price = 15 # seconds

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
    return Rails.cache.fetch(@@cache_key_cc_coin_list, :expires_in => @@cache_expiry_cc_coin_list.hours) do
      CryptoCompare.cc_coin_list(all_rows)
    end
  end

  def self.get_coin(symbol)
    full_summary = summary
    return full_summary.detect { |e| e.symbol == symbol }
  end

  def self.btc_to_dollar_euro_price
    return Rails.cache.fetch(@@btc_to_dollar_euro_price, :expires_in => @@cache_expiry_btc_price.seconds) do
      CryptoCompare.btc_to_dollar_euro_price
    end
  end
end
