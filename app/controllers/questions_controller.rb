class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_question_set
  before_action :require_login

  
  # GET /questions
  # GET /questions.json
  def index
    @questions = @question_set.questions
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    render json: @question
  end

  # POST /questions
  # POST /questions.json
  def create
    if current_user.teacher?(@question_set.class_group_id)
      @question = Question.new(question_params)
      @question.question_set_id = @question_set.id    
      respond_to do |format|
        if @question.save
          format.html { redirect_to question_set_questions_url, notice: 'Question was successfully created.' }
          format.json { render :show, status: :created, location: question_set_questions_url }
        else
          format.html { render :new }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      end
    else
      render :status => :forbidden, text: "You must be a teacher enrolled in the class to create a question."
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    if current_user.teacher?(@question_set.class_group_id)
      respond_to do |format|
        if @question.update(question_params)
          format.html { redirect_to question_set_questions_url, notice: 'Question was successfully updated.' }
          format.json { render :show, status: :ok, location: question_set_questions_url }
        else
          format.html { render :edit }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      end
    else
      render :status => :forbidden, text: "You must be a teacher enrolled in the class to create a question."
    end      
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    if current_user.teacher?(@question_set.class_group_id)
      @question.destroy
      respond_to do |format|
        format.html { redirect_to question_set_questions_url, notice: 'Question was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      render :status => :forbidden, text: "You must be a teacher enrolled in the class to delete a response."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    def set_question_set
      @question_set = QuestionSet.find(params[:question_set_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit!
    end
end
