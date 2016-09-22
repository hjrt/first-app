class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :record_user_activity

 # 	def current_user
 # 		@current_user ||= User.find_by_id!(session[:user_id])
 # 	end
	# helper_method :current_user

  protected

  def configure_permitted_parameters
    # added_attrs = [:username, :email, :password, :password_confirmation, :remember_me, :avatar, :avatar_cache, :remove_avatar]
    devise_parameter_sanitizer.permit :sign_up, keys: [:username, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_in, keys: [:username, :password, :remember_me]
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit( :remove_avatar, :username, :email, :avatar, :avatar_cache)
    end
  end

  private

  def record_user_activity
    if current_user
      current_user.touch :last_active_at
    end
  end

end