class CoinsController < ApplicationController
  def index
  end

  def show
    @coin_symbol = params[:id]
    @follow = Following.where(user_id: 1, coin_name: @coin_symbol)
    @is_following = @follow.length > 0 ? true : false
  end
end
