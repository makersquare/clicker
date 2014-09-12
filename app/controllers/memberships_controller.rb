class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]
  before_action :set_class_group, only: [:edit, :index, :show, :new, :create]
  before_action :require_login
  
  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = @class_group.memberships
    @users = @class_group.users
    @student_memberships = @class_group.memberships.where(kind: 'student')
    @teacher_memberships = @class_group.memberships.where(kind: 'teacher')
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  # POST /memberships.json
  def create
    @user = GetUserInfo.run(membership_params)
    @membership = Membership.new(
      user_id: @user.id,
      kind: membership_params['kind'],
      class_group_id: @class_group.id)
    respond_to do |format|
      if @membership.save
        format.html { redirect_to class_group_memberships_url, notice: 'Membership was successfully created.' }
        format.json { render :show, status: :created, location: @membership }
      else
        format.html { render :new }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to class_group_memberships_url, notice: 'Membership was successfully updated.' }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to memberships_url, notice: 'Membership was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    def set_class_group
      @class_group = ClassGroup.find(params[:class_group_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:kind, :nickname)
    end
end
