class LikesController < ApplicationController

	def create
	    @answer = Answer.find(params[:answer_id])
	    like = Like.new
	    like.answer = @answer
	    like.user = current_user
	    like.save
      	@answer.user.like_points
	    redirect_back(fallback_location: root_path)
	end

	def destroy
		@answer = Answer.find(params[:answer_id])
		Like.where({answer_id: params[:answer_id], user: current_user}).last.destroy
		@answer.user.unlike_points
	    redirect_back(fallback_location: root_path)
	end
end
