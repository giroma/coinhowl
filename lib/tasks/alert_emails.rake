desc 'Call Bittrex api and get last price of each coin, check against prices in alerts table'
task alerts: [:environment] do
  response = HTTParty.get('https://bittrex.com/api/v1.1/public/getmarketsummaries')
  response = JSON.parse(response.body)

  response_only_name_price = response['result'].map do |coin|
    {'MarketName' => coin['MarketName'],
      'Last' => coin['Last'] } # map to array of only MarketName and Last price of coin
  end

  response_only_btc_name_price =  response_only_name_price.select {|coin| coin['MarketName'].include?('BTC-')} #select only the BTC market

  all_alerts = Alert.all

  all_alerts.each do |alert|
    p api_price = response_only_btc_name_price.find_by {|coin| coin['MarketName'] == "BTC-#{alert.following.coin_name}"}
    p alert.following.coin_name
    # if alert.price_above > api_price
  end

end
