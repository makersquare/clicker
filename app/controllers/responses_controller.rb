class ResponsesController < ApplicationController
  before_action :set_response, only: [:show, :edit, :update, :destroy]
  before_action :set_question_set
  before_action :set_question
  before_action :require_login
  
  # GET /responses
  # GET /responses.json
  def index
    @responses = @question.responses
  end

  # GET /responses/1
  # GET /responses/1.json
  def show
  end

  # POST /responses
  # POST /responses.json
  def create
    @response = Response.new
    p response_params
    @response.content = response_params["content"]
    @response.user_id = @current_user.id
    @response.question_id = @question.id
    p @response
    if @response.content.nil?
      render json: {errors: :missing_content}, status: :unprocessable_entity    
    elsif @response.save
      render :show, {question_set_id: @question_set.id, question_id: @question.id, id: @response.id, status: :created}
    else
      render json: @response.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /responses/1
  # PATCH/PUT /responses/1.json
  def update
    if @response.update(response_params)
      render :show, status: :ok, location: @response
    else
      render json: @response.errors, status: :unprocessable_entity 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_response
      @response = Response.find(params[:id])
    end

    def set_question_set
      @question_set = QuestionSet.find(params[:question_set_id])
    end

    def set_question
      @question = Question.find(params[:question_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def response_params
      p params
      params.require("response").permit("content")
    end
end
