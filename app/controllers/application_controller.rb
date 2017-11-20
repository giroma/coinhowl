class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :call_coin_market_cap_api

  def call_coin_market_cap_api
    @response = HTTParty.get('https://api.coinmarketcap.com/v1/ticker/?convert=CAD&limit=5')
    @result = JSON.parse(@response.body)
  end
end
