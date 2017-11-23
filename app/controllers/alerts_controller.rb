class AlertsController < ApplicationController
  def create
    @alert = Alert.create
    @following = Following.find(params[:following_id])
    @alert.following_id = @following.id
    @alert.price_above = params[:alert][:price_above]
    @alert.price_below = params[:alert][:price_below]
    @alert.state = 'Active'

    if @alert.save!
      flash.notice = "Alert is activated."
      redirect_to following_index_path
    else
      render :edit
    end
end

def edit
  @alert = Alert.find(params[:id])
  @following = Following.find(params[:following_id])
end

def update
  @alert = Alert.find(params[:id])
  @follow = Following.find(params[:following_id])
  @alert.price_above = params[:alert][:price_above]
  @alert.price_below = params[:alert][:price_below]
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

  if @alert.destroy
    flash[:notice] = "Alert has been successfully deleted."
    redirect_to following_index_path
  else
    flash[:notice] = "Alert has failed to delete."
    redirect_to following_index_path
  end
end

end
