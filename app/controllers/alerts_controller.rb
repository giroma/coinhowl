class AlertsController < ApplicationController
  def create
    @alert = Alert.create
    @following = Following.find(params[:following_id])
    @alert.following_id = @following
    @alert.price_above = [:alert][:price_above]
    @alert.price_below = [:alert][:price_below]
    @alert.state = 'active'

    if @alert.save
      flash.notice = "Alert is activated."
      redirect_to @following
    else
      render following_path(@following)
    end
end

def edit
  @alert = Alert.find(params[:id])
  @following = Following.find(params[:following_id])
end

def update
  @alert = Alert.find(params[:id])
  @following = Following.find(params[:following_id])
  @alert.price_above = params[:alert][:price_above]
  @alert.price_below = params[:alert][:price_below]
  @alert.following_id = @following

  if @alert.save
    flash.notice = "Alert has been successfully updated."
    redirect_to @following
  else
    render :edit
  end
end

def destroy
  @alert = Alert.find(params[:id])

  if @alert.destroy
    flash[:notice] = "Alert has been successfully deleted."
    redirect_to following_path(params[:following_id])
  else
    render :show
  end
end

end
