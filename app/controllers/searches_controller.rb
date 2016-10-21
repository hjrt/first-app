class SearchesController < ApplicationController

  def index
    @questions = Search.find_questions(params[:search][:keywords])
    @answers = Search.find_answers(params[:search][:keywords])
    @users = Search.find_users(params[:search][:keywords])
  end
  
  private
  
  def allowed_params
    params.require(:search).permit(:keywords)
  end

end
