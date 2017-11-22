class FollowingController < ApplicationController
  def index
    @following = Following.where(user_id: current_user.id)
  end

  def update
    @follow = Following.new
    @follow.user_id = current_user.id
    @follow.coin_name = params[:id]

    if @follow.save
      redirect_to coin_path
    else
      redirect_to coins_url
    end
  end

  def destroy
    @coin_symbol = params[:id]
    @follow = Following.where(user_id: current_user.id, coin_name: @coin_symbol)

    if Following.destroy(@follow.ids)
      redirect_to coin_path
    else
      redirect_to coins_url
    end
  end
end

# @follow.coin_name and  @coin is referring to the show page of the coin the user is currently on
