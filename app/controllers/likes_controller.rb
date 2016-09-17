class LikesController < ApplicationController

	def create
	    @like = Like.create(params[:like])
	    @answer = Answer.find(params[:answer_id])
	    @like.user = current_user
	    redirect_to :back
	end

	def destroy
	    like = Like.find(params[:id]).destroy
	    @answer = like.answer
	    redirect_to :back
	end
end
