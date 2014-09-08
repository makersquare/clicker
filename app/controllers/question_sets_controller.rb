class QuestionSetsController < ApplicationController
  before_action :set_question_set, only: [:show, :edit, :update, :destroy]

  # GET /question_sets
  # GET /question_sets.json
  def index
    @question_sets = QuestionSet.all
  end

  # GET /question_sets/1
  # GET /question_sets/1.json
  def show
  end

  # GET /question_sets/new
  def new
    @question_set = QuestionSet.new
  end

  # GET /question_sets/1/edit
  def edit
  end

  # POST /question_sets
  # POST /question_sets.json
  def create
    @question_set = QuestionSet.new(question_set_params)

    respond_to do |format|
      if @question_set.save
        format.html { redirect_to @question_set, notice: 'Question set was successfully created.' }
        format.json { render :show, status: :created, location: @question_set }
      else
        format.html { render :new }
        format.json { render json: @question_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /question_sets/1
  # PATCH/PUT /question_sets/1.json
  def update
    respond_to do |format|
      if @question_set.update(question_set_params)
        format.html { redirect_to @question_set, notice: 'Question set was successfully updated.' }
        format.json { render :show, status: :ok, location: @question_set }
      else
        format.html { render :edit }
        format.json { render json: @question_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /question_sets/1
  # DELETE /question_sets/1.json
  def destroy
    @question_set.destroy
    respond_to do |format|
      format.html { redirect_to question_sets_url, notice: 'Question set was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_set
      @question_set = QuestionSet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_set_params
      params.require(:question_set).permit(:name)
    end
end
