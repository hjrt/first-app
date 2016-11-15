class UsersController < ApplicationController
  before_action :authenticate_user!
  respond_to :js

  def index 
    @users = User.all
    if params[:search]
      @users = User.search(params[:search])
    end
  end

  def show
    @user=User.friendly.find(params[:id])
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

  def profile_page_users_posts
    @user = User.find(params[:user])
  end

  def profile_page_users_friends
    @user = User.find(params[:user])
  end

  def profile_page_users_badges
    @user = User.find(params[:user])
  end

  def sort_questions_by_newest
    @user = User.find(params[:user])
  end

  def sort_questions_by_accepted
    @user = User.find(params[:user])
  end

  def sort_answers_by_newest
    @user = User.find(params[:user])
  end

  def sort_answers_by_likes
    @user = User.find(params[:user])
  end

  private

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end
end