desc 'Call Bittrex api and get last price of each coin, check against prices in alerts table'
task alerts: [:environment] do
  response = HTTParty.get('https://bittrex.com/api/v1.1/public/getmarketsummaries')
  response = JSON.parse(response.body)

  response_only_name_price = response['result'].map do |coin|
    {'MarketName' => coin['MarketName'],
      'Last' => coin['Last'] } # map to array of only MarketName and Last price of coin
  end

  response_only_btc_name_price = response_only_name_price.select {|coin| coin['MarketName'].include?('BTC-')} #select only the BTC market

  database_alerts = Alert.all #from our database

  database_alerts.each do |alert|
    api_coin = response_only_btc_name_price.select {|coin| coin['MarketName'] == "BTC-#{alert.following.coin_name}"} #returns an active record container with an array of 1 element so need to do [0]

    api_coin_name = api_coin[0]['MarketName']
    api_coin_price = api_coin[0]['Last'] #to acces the 0 array and return ony price

    #trigger when current price is above the alert price_above
    if api_coin_price > alert.price_above
      # p "#{api_coin_name} is above:#{alert.price_above} current:#{api_coin_price}"
      UserMailer.alert_email_above(alert.following.user.email, alert).deliver_now
    end
    #trigger when current price is below the alert price_below
    if api_coin_price < alert.price_below
      # p "#{api_coin_name} is below:#{alert.price_below} current:#{api_coin_price}"
      UserMailer.alert_email_below(alert.following.user.email, alert).deliver_now
    end

  end

end
