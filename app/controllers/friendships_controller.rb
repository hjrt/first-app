class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def request_friendship
    friend = User.find(params[:friend])
    action = Friendship.request(current_user, friend)
    redirect_back(fallback_location: root_path)
  end

  def accept_friendship
    user = current_user
    friend = User.find(params[:friend])
    action = Friendship.accept(user, friend)
    redirect_back(fallback_location: root_path)
  end


  def destroy_friendship
    friend = User.find(params[:friend])
    action = Friendship.destroy(current_user, friend)  
    redirect_back(fallback_location: root_path)
  end


end
