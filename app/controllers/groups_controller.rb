class GroupsController < ApplicationController
  before_action :set_group, only: %i[show update destroy]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
    @categories = %w[Studies Housing Transportation Foods Utilities Clothing Healthcare Entertainment
    Personal Savings]
  end

  def show
  end

  def create
    @group = Group.new(group_params)
    @group.icon = "#{@group.name}.jpg"

    respond_to do |format|
      if @group.save
        format.html { redirect_to groups_url, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to group_url(@group), notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_path, notice: 'Group deleted' }
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name).merge(user: current_user)
  end
end
