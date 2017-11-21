class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :cache_coin_market_cap

  def cache_coin_market_cap
    @response = HTTParty.get('https://api.coinmarketcap.com/v1/ticker/?convert=CAD&limit=5')
    @result = JSON.parse(@response.body)
  end
end
