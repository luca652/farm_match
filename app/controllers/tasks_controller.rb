class TasksController < ApplicationController

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
    @categories = Task::CATEGORIES
    @options_for_subcategory = []
    @options_for_services = []
  end

  def create
    @task = Task.new(task_params)
    @categories = Task::CATEGORIES

    if @task.save
      redirect_to task_path(@task), notice: 'Task was successfully created'
    else
      @task.category.present? ? @options_for_subcategory = Task::SUBCATEGORIES[@task.category] : @options_for_subcategory = []
      @task.subcategory.present? ? @options_for_services = Service::SERVICES[@task.subcategory] : @options_for_services = []
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @task = Task.find(params[:id])
    @options_for_services = Service::SERVICES[@task.subcategory]
    @checked_services = set_checked_services(@task, @options_for_services)
  end


  def options_for_subcategory
    @target = params[:target]
    @category = params[:category]
    @options_for_subcategory = Task::SUBCATEGORIES[@category]

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

  def set_checked_services(task, options_for_services)
    checked_services = options_for_services.select do |service|
      task.services.any? { |s| s.name == service }
    end
    checked_services
  end
end
