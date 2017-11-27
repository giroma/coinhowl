class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.username = params[:user][:username]
    @user.email = params[:user][:email]
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
  end

  def update
    @user = current_user
  end
end
