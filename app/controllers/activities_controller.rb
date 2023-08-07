class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[show edit update destroy]

    def index
      @group = Group.find(params[:group_id])
      @group_activities = GroupActivity.where(group_id: params[:group_id]).order('created_at DESC')
      @activities = []
      @group_activities.each do |a|
      activity = Activity.find(a.activity_id)
      @activities << activity
    end
  end

  def show
  end


  def new
    @id = params[:group_id]
    @name = Group.find(params[:group_id]).name
    puts @group.inspect
    @activity = Activity.new
    @group = Group.find(params[:group_id])
    @activity = @group.activities.build
  end

  def edit
  end

  def create
    @activity = Activity.new(activity_params)
    @group_activity = GroupActivity.new(group: Group.find(params[:group_id]), activity: @activity)

    respond_to do |format|
      if @activity.save && @group_activity.save
        format.html do
          redirect_to "/groups/#{params[:group_id]}/activities", notice: 'Transaction was successfully created.'
        end
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to activity_url(@activity), notice: 'Activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to activities_url, notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:name, :amount).merge(author: current_user)
  end
end
