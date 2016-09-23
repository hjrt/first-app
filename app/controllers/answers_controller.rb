class AnswersController < ApplicationController
  before_action :set_answer, only: [:edit]
  before_action :authenticate_user!, except: [:index, :show]

  
  def index
    @answers = Answer.all
  end

  def create
    @answer = Answer.new(answer_params)
    @question = Question.find(params[:question_id])
    @answer.question = @question
    @answer.user = current_user

    respond_to do |format|
      if @answer.save
        UserMailer.delay.question_answered(@answer.question.user, @answer, @answer.question)
        format.html { redirect_to question_path(@question), notice: 'Answer was successfully created.' }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { redirect_to question_path(@question) }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  def accept
    @answer=Answer.find(params[:id])
    @answer.accepted = true
    question = @answer.question
    question.accepted = true
    question.save
    
    if @answer.save
      @answer.user.manage_points(25)
      UserMailer.delay.answer_accepted(@answer.user, @answer, @answer.question)
      flash[:notice] = "You accepted the answer"
    else
      flash[:notice] = "Try again later"
    end
    redirect_to @answer.question
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:content)
    end
end
