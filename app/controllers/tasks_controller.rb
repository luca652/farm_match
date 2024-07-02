class TasksController < ApplicationController

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
    @categories = Task::CATEGORIES
  end

  def create
    @task = Task.new(task_params)
    @categories = Task::CATEGORIES

    if @task.save
      redirect_to new_task_service_path(@task), notice: 'Task was successfully created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def subcategories
    @target = params[:target]
    @category = params[:category]
    @subcategories = Task::SUBCATEGORIES[@category]

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def task_params
    params.require(:task).permit(:headline, :description, :category, :subcategory, :user_id, :latitude, :longitude)
  end
end
