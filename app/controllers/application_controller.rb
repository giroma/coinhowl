require_relative '../services/coin_service'


class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :require_login

  before_action :btc_to_dollar_euro_price

  def btc_to_dollar_euro_price
    @btc_to_dollar_euro_price = CoinService.btc_to_dollar_euro_price
  end
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    session[:user_id] != nil if current_user
  end

  def require_login
    if !logged_in?
      flash[:alert] = "You must log in first."
      redirect_to login_path, status: 200
    end
  end

end
