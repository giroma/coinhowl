class CoinsController < ApplicationController
  def index
    @response = HTTParty.get('https://api.coinmarketcap.com/v1/ticker/?convert=CAD&limit=5')
    @result = JSON.parse(@response.body)

    call_cryptocompare_api
  end

  def show
  end
end
