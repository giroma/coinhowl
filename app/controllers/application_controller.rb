class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :cache_coin_market_cap

  def cache_coin_market_cap
    @response = HTTParty.get('https://api.coinmarketcap.com/v1/ticker/?convert=CAD&limit=5')
    @result = JSON.parse(@response.body)
  end

  def call_cryptocompare_api
    @cryptocompare = HTTParty.get('https://www.cryptocompare.com/api/data/coinlist/')
    @cryptocompare_result = JSON.parse(@cryptocompare.body)
    @cryptocompare_result = @cryptocompare_result["Data"]
    base_cc_url = @cryptocompare_result["BaseImageUrl"]
    # coin_image = @cryptocompare_result[cc_symbol]["ImageUrl"]
    # @coin_image_url = "#{base_cc_url}+#{coin_image}"
  end
  helper_method :current_user
  helper_method :ensure_logged_in
  helper_method :ensure_ownership

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # def ensure_logged_in
  #   if !current_user
  #     flash[:alert] = "Please log in"
  #     redirect_to root_url
  #   end
  # end
  #
  # def ensure_ownership
  #   if current_user.id != @project.user_id
  #     flash[:alert] = 'Not authorized owner'
  #     redirect_to root_url
  #   end
  # end

end
