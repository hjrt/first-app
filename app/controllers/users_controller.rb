class UsersController < ApplicationController
  before_action :authenticate_user!

  def index 
    @users = User.all.order(points: :desc)
    if params[:search]
      @users = User.search(params[:search])
    end
  end

  def show
    @user=User.find(params[:id])
  end

  def profile
    @user = current_user
  end

  def edit_password
    @user = current_user
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update_with_password(user_params) 
      # Sign in the user by passing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      render "edit"
    end
  end

  private

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end
end