class FriendRequestsController < ApplicationController
	before_action :set_friend_request, except: [:index, :new]

	def index
		@incoming = FriendRequest.where(friend: current_user)
		@outgoing = current_user.friend_requests
	end

	def new
		@friend_request = FriendRequest.new
	end

	def create
		friend = User.find(params[:friend_id])
    	@friend_request = current_user.friend_requests.new(friend: friend)
		@friend_request.save
	end

	def show

	end

	def destroy
		@friend_request.destroy
		head :no_content
	end

	private

	def set_friend_request
		@friend_request = FriendRequest.find(params[:id])
	end
end