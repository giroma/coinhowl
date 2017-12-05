class AlertsController < ApplicationController
  def create
    @alert = Alert.new
    @following = Following.find(params[:following_id])
    @alert.following_id = @following.id
    @alert.price_above = params[:alert][:price_above]
    @alert.price_below = params[:alert][:price_below]
    @alert.percent = params[:alert][:percent]
    @alert.state = 'Active'
    @coin = params[:id]
    if @alert.save
      flash.notice = 'Alert successfully created.'
      # redirect_to following_index_path
    else
      flash.notice = 'Alert failed to save'
      # redirect_to coin_path(@coin)
    end
    # respond_to do |format|
    #   format.html
    #   format.json do
    #     if @alert.save
    #       render json:{}, nothing: true, status: 204
    #       flash.notice = "Alert is activated."
    #     else
    #       render json:{}, nothing: true, status: 400
    #     end
    #   end
    # end
  end

  def edit
    @alert = Alert.find(params[:id])
    @following = Following.find(params[:following_id])
  end

  def update
    @alert = Alert.find(params[:id])
    @alert.price_above = params[:alert][:price_above]
    @alert.price_below = params[:alert][:price_below]
    @alert.percent = params[:alert][:percent]
    @alert.state = 'Active'

    if @alert.save
      flash.notice = "Alert has been successfully updated."
      redirect_to following_index_path
    else
      render :edit
    end
  end

  def destroy
    @alert = Alert.find(params[:id])
    @following = Following.find(params[:following_id])
    @alerts = @following.alerts

    respond_to do |format|
    if @alert.destroy
      format.html { redirect_to @alert }
      format.js
      format.json { render json: @alert, status: :deleted, location: @alert }
    else
      format.html { render action: "delete" }
      format.json { render json: @alert.errors, status: :unprocessable_entity }
    end
  end

  #   if @alert.destroy

  #   else
  #     flash[:alert] = "Alert has failed to delete."
  #     redirect_to following_index_path
  #   end
  end

  def alert_form
    @alert = Alert.new
    @following = current_user.following.find_by(coin_name: params[:following_id])
    render 'alerts/_form1', layout: false
  end
end
