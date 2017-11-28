desc 'Call Bittrex api and get last price of each coin, check against prices in alerts table'
task alerts: [:environment] do
  response = HTTParty.get('https://bittrex.com/api/v1.1/public/getmarketsummaries')
  response = JSON.parse(response.body)

  response_only_name_price_prevday = response['result'].map do |coin|
    {'MarketName' => coin['MarketName'],
      'Last' => coin['Last'],
     'PrevDay' => coin['PrevDay']} # map to array of only MarketName and Last price of coin, and prev day price
  end

  response_only_btc_name_price_prevday = response_only_name_price_prevday.select {|coin| coin['MarketName'].include?('BTC-')} #select only the BTC market

  database_alerts = Alert.where(state: 'Active') #from our database, active alerts only

  database_alerts.each do |alert|
    api_coin = response_only_btc_name_price_prevday.select {|coin| coin['MarketName'] == "BTC-#{alert.following.coin_name}"} #returns an active record container with an array of 1 element so need to do [0]

    api_coin_name = api_coin[0]['MarketName']
    api_coin_price = api_coin[0]['Last'] # to acces the 0 array and return ony price
    api_coin_percent = ((api_coin[0]['Last'])/(api_coin[0]['PrevDay'])-1)*100 # gives percent change from prev day

          # ------EMAIL-------
    if alert.following.user.email_alert # trigger only when email_alert is set to true, meaing user wants to recieve email alerts

      #trigger when current price is above the alert price_above
      if api_coin_price > alert.price_above
        UserMailer.alert_email_above(alert.following.user.email, alert).deliver_now
        alert.state = 'Inactive' #change alert state to inactive once triggered
        alert.save
      end if alert.price_above != nil # only triger if value is not nil

      #trigger when current price is below the alert price_below
      if api_coin_price < alert.price_below
        UserMailer.alert_email_below(alert.following.user.email, alert).deliver_now
        alert.state = 'Inactive'
        alert.save
      end if alert.price_below != nil

      # trigger when price has changed more % in a day than alert %
      if api_coin_percent.abs > alert.percent
        UserMailer.alert_email_percent(alert.following.user.email, alert).deliver_now
        alert.state = 'Inactive'
        alert.save
      end
    end

        #-------SMS--------
    if alert.following.user.phone_alert #only if user wants sms alerts
      if api_coin_price > alert.price_above
        body = "id:#{alert.id} #{alert.following.coin_name} > #{alert.price_above}"
        send_alert_sms(alert, body)
        alert.state = 'Inactive' #change alert state to inactive once triggered
        alert.save
      end if alert.price_above != nil # only triger if value is not nil therwise nil evaluation o error occurs

      #trigger when current price is below the alert price_below
      if api_coin_price < alert.price_below
        body = "id:#{alert.id} #{alert.following.coin_name} < #{alert.price_below}"
        send_alert_sms(alert, body)
        alert.state = 'Inactive'
        alert.save
      end if alert.price_below != nil

      # trigger when price has changed more % in a day than alert %
      if api_coin_percent.abs > alert.percent
        body = "id #{alert.id} #{alert.following.coin_name} price has changed over #{alert.percent}%"
        send_alert_sms(alert, body)
        alert.state = 'Inactive'
        alert.save
      end
    end
  end
end

def send_alert_sms(alert, body)
  client = Twilio::REST::Client.new(ENV['TWILIO_ID'], ENV['TWILIO_TOKEN'])

  client.api.account.messages.create(
    from: ENV['PHONE_NUMBER'],
    to: "+1#{alert.following.user.phone}",
    body: body
  )
end
