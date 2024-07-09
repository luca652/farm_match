class TasksController < ApplicationController

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
    @categories = Task::CATEGORIES
    @options_for_services = []
  end

  def create

    @task = Task.new(task_params)
    @categories = Task::CATEGORIES

    if @task.save
      redirect_to task_path(@task), notice: 'Task was successfully created'
    else
      @options_for_services = []
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

  def options_for_services
    @target = params[:target]
    @subcategory = params[:subcategory]
    @options_for_services = Service::SERVICES[@subcategory]

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def task_params
    params.require(:task).permit(:headline, :description, :category, :subcategory, :user_id, :latitude, :longitude, services_attributes: [:name])
  end
end
