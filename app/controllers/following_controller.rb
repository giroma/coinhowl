class FollowingController < ApplicationController
  def index
    @following = Following.where(user_id: 1)
  end

  def new
    @following = Following.new
  end

  def create
    call_coin_market_cap_api
    @following = Following.new
    @following.user_id = current_user
    @following.coin_name = params[:coin]["symbol"]

    # if @following.save
    #   redirect_to
    # end
  end
end
