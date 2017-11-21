class FollowingController < ApplicationController
  def index
    @following = Following.where(user_id: 1)
  end

  def update
    @follow = Following.new
    @follow.user_id = 1
    @follow.coin_name = params[:id]
    puts @follow.inspect
    # if @following.save
    #   redirect_to
    # end
  end
end
