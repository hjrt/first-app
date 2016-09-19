class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :question_user, only: [:destroy, :edit, :update]
  before_action :user_has_enough_points, only: [:new, :create]
  before_action :answer_accepted, only: [:edit, :update]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @answer = Answer.new
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.user = current_user

    respond_to do |format|
      if @question.save
         @question.user.question_points
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :content)
    end

    def question_user
      if current_user != @question.user
        flash[:danger] = "That's not your question so you can't do that. But hey, you can ask your own, brand new question!"
        redirect_back(fallback_location: root_path)
      end
    end

    def user_has_enough_points
      unless current_user.points > 0
        flash[:danger] = "You don't have enough points to ask new question. You need at least 10 points to do it."
        redirect_back(fallback_location: root_path)
      end
    end

    def answer_accepted
      if @question.accepted
        flash[:notice] = "This question has an accepted answer, so you can't edit it anymore."
        redirect_back(fallback_location: root_path)
      end
    end
end
