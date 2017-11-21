class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :ensure_logged_in
  helper_method :ensure_ownership

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # def ensure_logged_in
  #   if !current_user
  #     flash[:alert] = "Please log in"
  #     redirect_to root_url
  #   end
  # end
  #
  # def ensure_ownership
  #   if current_user.id != @project.user_id
  #     flash[:alert] = 'Not authorized owner'
  #     redirect_to root_url
  #   end
  # end

end
