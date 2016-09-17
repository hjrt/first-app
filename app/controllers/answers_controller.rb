class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  
  # def current_user
  # @answer = current_user.answers.find_by(id: params[:id])
  # redirect_to_answers_path, notice: "you have no permission to delete this answer" if @answer.nil?
  # end


  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  # def show
  # end

  # GET /answers/1/edit
 # def edit
 # end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)
    @question = Question.find(params[:question_id])
    @answer.question = @question
    @answer.user = current_user

    respond_to do |format|
      if @answer.save
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
