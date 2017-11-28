class UsersController < ApplicationController

  before_action :call_coin_market_cap
  before_action :call_bittrex

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.username = params[:user][:username]
    @user.email = params[:user][:email]
    @user.phone = params[:user][:phone]
    @user.email_alert = true
    @user.phone_alert = false
    @user.avatar_url = "https://api.adorable.io/avatars/60/#{@user.username}.png"
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      auto_login(@user)
      redirect_to root_url
      # Tell the UserMailer to send a welcome email after save
        UserMailer.welcome_email(@user).deliver_now


    else
      flash.now[:alert] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = current_user
    if current_user == nil
      redirect_to root_url
      flash[:alert] = "You must be logged-in to see this page"
    end

    @avatar = @user.avatar_url
  end

  def update
    @user = current_user
    @user.phone = params[:user][:phone]
    @user.phone_alert = params[:phone_alert] || false
    @user.email_alert = params[:email_alert] || false
    if @user.save
      # send_confirmation_sms
      flash[:alert] = "Successfully updated"
      redirect_to user_path(@user)
    else
      flash.now[:alert] = @user.errors.full_messages
      render :edit
    end
  end

end
