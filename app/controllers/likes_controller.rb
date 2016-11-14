class LikesController < ApplicationController

  def create
    @answer = Answer.find(params[:answer_id])
    like = Like.new
    like.answer = @answer
    like.user = current_user
    like.save
    @answer.user.manage_points(5)
    @answer.manage_likes_number(1)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @answer = Answer.find(params[:answer_id])
    Like.where({answer_id: params[:answer_id], user: current_user}).last.destroy
    @answer.user.manage_points(-5)
    @answer.manage_likes_number(-1)
    redirect_back(fallback_location: root_path)
  end

end
