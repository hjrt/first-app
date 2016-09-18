class LikesController < ApplicationController

	def create
	    @answer = Answer.find(params[:answer_id])
	    like = Like.new
	    like.answer = @answer
	    like.user = current_user
	    like.save
	    redirect_to :back
	end

	def destroy
	    Like.where({answer_id: params[:answer_id], user: current_user}).last.destroy
	    redirect_to :back
	end

end
