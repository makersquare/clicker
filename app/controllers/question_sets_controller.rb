class QuestionSetsController < ApplicationController
  before_action :set_question_set, only: [:show, :edit, :update, :destroy]
  before_action :set_class_group
  respond_to :json
  before_action :require_login

  # GET /question_sets
  # GET /question_sets.json
  def index
    @question_sets = @class_group.question_sets
  end

  # GET /question_sets/1
  # GET /question_sets/1.json
  def show
    if @current_user.enrolled?(@class_group.id)
      if @current_user.teacher?(@class_group.id)
        render "teacher_show"
      else
        render "student_show"
      end
    else
      redirect_to class_groups_path
      return
    end
  end

  # POST /question_sets
  # POST /question_sets.json
  def create
    # return render :json => { :id => 99, :name => "Hello Class", :class_group_id => 1 }
    if current_user.teacher?(@class_group.id)
      @question_set = QuestionSet.new(question_set_params)
      @question_set.class_group_id = @class_group.id

      respond_to do |format|
        if @question_set.save
          format.html { redirect_to [@class_group, @question_set], notice: 'Question set was successfully created.' }
          format.json { render :show, status: :created, location: [@class_group, @question_set] }
        else
          format.html { render :new }
          format.json { render json: @question_set.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:error_not_teacher] = "You must be a teacher to perform this action."
      redirect_to class_groups_path
    end
  end

  # PATCH/PUT /question_sets/1
  # PATCH/PUT /question_sets/1.json
  def update
    if current_user.teacher?(@class_group.id)
      respond_to do |format|
        if @question_set.update(question_set_params)
          @question_set = QuestionSet.new(question_set_params)
          @question_set.class_group_id = @class_group.id
          
          format.html { redirect_to [@class_group, @question_set], notice: 'Question set was successfully updated.' }
          format.json { render :show, status: :ok, location: [@class_group, @question_set] }
        else
          format.html { render :edit }
          format.json { render json: @question_set.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:error_not_teacher] = "You must be a teacher to perform this action."
      redirect_to class_groups_path
    end      
  end

  # DELETE /question_sets/1
  # DELETE /question_sets/1.json
  def destroy
    if current_user.teacher?(@class_group.id)
      @question_set.destroy
      respond_to do |format|
        format.html { redirect_to class_group_question_sets_url, notice: 'Question set was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      flash[:error_not_teacher] = "You must be a teacher to perform this action."
      redirect_to class_groups_path
    end       
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_set
      @question_set = QuestionSet.find(params[:id])
    end

    def set_class_group
      @class_group = ClassGroup.find(params[:class_group_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_set_params
      params.require(:question_set).permit!
    end
end
