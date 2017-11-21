class CoinsController < ApplicationController
  def index
  end

  def show
    @coin = params[:id]
    @follow = Following.where(user_id: 1, coin_name: @coin)
    puts @follow.inspect
    @is_following = @follow.length > 0 ? true : false
  end
end
