class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def call_cryptocompare_api
    @cryptocompare = HTTParty.get('https://www.cryptocompare.com/api/data/coinlist/')
    @cryptocompare_result = JSON.parse(@cryptocompare.body)
    @cryptocompare_result = @cryptocompare_result["Data"]
    base_cc_url = @cryptocompare_result["BaseImageUrl"]
    # coin_image = @cryptocompare_result[cc_symbol]["ImageUrl"]
    # @coin_image_url = "#{base_cc_url}+#{coin_image}"
  end
end
