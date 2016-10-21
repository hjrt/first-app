class FriendshipsController < ApplicationController

  def create
  @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
  if @friendship.save
    flash[:notice] = "Friend request has been sent."
    redirect_back(fallback_location: root_path)
  else
    flash[:notice] = "Unable to sent friend request."
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Unfriended."
    redirect_back(fallback_location: root_path)
  end

end
