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
    @response = Response.new(response_params)
    @response.user_id = @current_user.id
    @response.question_id = @question.id
    if @response.save
      render :show, status: :created, location: @response
    else
      render json: @response.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /responses/1
  # PATCH/PUT /responses/1.json
  def update
    respond_to do |format|
      if @response.update(response_params)
        render :show, status: :ok, location: @response
      else
        render json: @response.errors, status: :unprocessable_entity 
      end
    end
  end

  # DELETE /responses/1
  # DELETE /responses/1.json
  def destroy
    @response.destroy
    respond_to do |format|
      format.html { redirect_to responses_url, notice: 'Response was successfully destroyed.' }
      format.json { head :no_content }
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
      params.require(:response).permit(:content)
    end
end
