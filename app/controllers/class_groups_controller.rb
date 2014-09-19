class ClassGroupsController < ApplicationController
  before_action :set_class_group, only: [:show, :edit, :update, :destroy]
  before_action :require_login
  respond_to :json, :html
  
  # GET /class_groups
  # GET /class_groups.json
  def index
    @class_groups = @current_user.class_groups
    @class_group = ClassGroup.new
  end

  # GET /class_groups/1
  # GET /class_groups/1.json
  def show
    if @current_user.enrolled?(@class_group.id)
      @question_sets = @class_group.question_sets   
    else
      redirect_to class_groups_path
      return
    end
  end

  # GET /class_groups/1/edit
  def edit
    redirect_to "/class_groups/" + params[:id] + "/#/edit"
  end

  # POST /class_groups
  # POST /class_groups.json
  def create
    if !@current_user.verified 
      redirect_to class_groups_path
      return
    end
    @class_group = ClassGroup.new(class_group_params)


    respond_to do |format|
      if @class_group.save
        Membership.create(
          user_id: @current_user.id,
          class_group_id: @class_group.id,
          kind: 'teacher')
        format.html { redirect_to @class_group, notice: 'Class group was successfully created.' }
        format.json { render :show, status: :created, location: @class_group }
      else
        @class_groups = @current_user.class_groups
        format.html { render :index }
        format.json { render json: @class_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /class_groups/1
  # PATCH/PUT /class_groups/1.json
  def update
    respond_to do |format|
      if @class_group.update(class_group_params)
        format.html { redirect_to @class_group, notice: 'Class group was successfully updated.' }
        format.json { render :show, status: :ok, location: @class_group }
      else
        format.html { render :edit }
        format.json { render json: @class_group.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_class_group
      @class_group = ClassGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def class_group_params
      params.require(:class_group).permit(:name, :description)
    end
end
