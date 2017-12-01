class FollowingController < ApplicationController
  before_action :call_bittrex

  def index
    @user = current_user
    @following = Following.where(user_id: @user.id)
    @avatar = @user.avatar_url
    @alert = Alert.new
  end

  def update
      if current_user
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
        else
          flash[:alert] = "Sorry, something went wrong. Please try again."
          redirect_to coin_path
        end
      else
          flash[:alert] = "You must have an account to follow a coin."
          redirect_to new_user_path
        end
  end

  def destroy
    @coin_symbol = params[:id]
    @follow = Following.find_by(user_id: current_user.id, coin_name: @coin_symbol)
    if @follow != nil
      @follow.alerts.delete_all
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
