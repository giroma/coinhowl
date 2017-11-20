class CoinsController < ApplicationController
  def index
    call_coin_market_cap_api
  end

  def show
  end
end
