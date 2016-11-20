class LikesController < ApplicationController
  respond_to :js, :html

  def create
    @answer = Answer.find(params[:id])
    like = Like.new
    like.answer = @answer
    like.user = current_user
    like.save
    @answer.user.manage_points(5)
    @answer.manage_likes_number(1)
    @question = Question.find(params[:question_id])
  end

  def destroy
    @answer = Answer.find(params[:id])
    Like.where({answer_id: params[:id], user: current_user}).last.destroy
    @answer.user.manage_points(-5)
    @answer.manage_likes_number(-1)
    @question = Question.find(params[:question_id])
  end

end
