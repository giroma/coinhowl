class FollowingController < ApplicationController

  before_action :require_login

  def index
    @user = current_user
    @following = Following.where(user_id: @user.id)
    @avatar = @user.avatar_url
    @alert = Alert.new
    @coin_summary = CoinService.summary
    @cc_coin_list = CoinService.cc_coin_list(@coin_summary)
  end

  def update
    @coin_symbol = params[:id]
    @is_following = Following.find_by(user_id: current_user.id, coin_name: @coin_symbol)
    if !@is_following
      @follow = Following.new
      @follow.user_id = current_user.id
      @follow.coin_name = params[:id]

      respond_to do |format|
        format.html
        format.json do
          if @follow.save
            render json:{}, nothing: true, status: 204
          else
            render json:{}, nothing: true, status: 400
          end
        end
      end
    end
  end

  def destroy
    @coin_symbol = params[:id]
    @follow = Following.find_by(user_id: current_user.id, coin_name: @coin_symbol)
    @alerts = @follow.alerts
    @nil_following_ids = Alert.where(following_id: nil)

    if @alerts.present?
      @alerts.delete_all # this deletes the following_id foreign key so we don't get the error "violates foreign key rule"
      @nil_following_ids.destroy_all # after the foreign key is removed, we delete the alerts with the following_id: nil
    end

    respond_to do |format|
      format.html
      format.json do
        if @follow.destroy
          render json:{}, nothing: true, status: 204
        else
          render json:{}, nothing: true, status: 400
        end
      end
    end
  end
end

# @follow.coin_name and  @coin_symbol is referring to the show page of the coin the user is currently on
