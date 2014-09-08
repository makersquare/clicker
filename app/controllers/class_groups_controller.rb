class ClassGroupsController < ApplicationController
  before_action :set_class_group, only: [:show, :edit, :update, :destroy]

  # GET /class_groups
  # GET /class_groups.json
  def index
    @class_groups = ClassGroup.all
  end

  # GET /class_groups/1
  # GET /class_groups/1.json
  def show
  end

  # GET /class_groups/new
  def new
    @class_group = ClassGroup.new
  end

  # GET /class_groups/1/edit
  def edit
  end

  # POST /class_groups
  # POST /class_groups.json
  def create
    @class_group = ClassGroup.new(class_group_params)

    respond_to do |format|
      if @class_group.save
        format.html { redirect_to @class_group, notice: 'Class group was successfully created.' }
        format.json { render :show, status: :created, location: @class_group }
      else
        format.html { render :new }
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

  # DELETE /class_groups/1
  # DELETE /class_groups/1.json
  def destroy
    @class_group.destroy
    respond_to do |format|
      format.html { redirect_to class_groups_url, notice: 'Class group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_class_group
      @class_group = ClassGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def class_group_params
      params.require(:class_group).permit(:name)
    end
end
