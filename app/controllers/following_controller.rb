class FollowingController < ApplicationController
  def index
    @following = Following.where(user_id: 1)
  end

  def update
    @follow = Following.new
    @follow.user_id = 1
    @follow.coin_name = params[:id]
    @follow.save
    puts @follow.inspect
    # if @following.save
    #   redirect_to
    # end
  end

  def destroy
    @coin = params[:id]
    @following = Following.where(user_id: 1, coin_name: @coin)
    @following.each do |follow|
      puts follow.inspect
      Following.delete(follow.id)
    end
  end
end
