class TasksController < ApplicationController

  def show
    @task = Task.find(params[:id])
  end

  def new_step_one
    @task = Task.new
    @categories = Task::CATEGORIES
    @options_for_subcategory = []
  end

  def create_step_one
    @task = Task.new(task_params)
    if @task.valid?
      session[:task_params] = task_params
      redirect_to new_step_two_tasks_path
    else
      render :new_step_one, status: :unprocessable_entity
    end
  end

  def new_step_two
    @task = Task.new(session[:task_params])
    @options_for_services = Service::SERVICES[@task.subcategory]
    @task.services.build(@options_for_services.map { |service| { name: service } })
  end

  def create
    @task = Task.new(session[:task_params])
    @task.assign_attributes(task_params)
    if @task.save
      session.delete(:task_params)
      redirect_to task_path(@task), notice: 'Task was successfully created'
    else
      @task.services_attributes = params[:task][:services_attributes]
      render :new_step_two, status: :unprocessable_entity
    end
  end

  # def new
  #   @task = Task.new
  #   @categories = Task::CATEGORIES
  #   @options_for_subcategory = []
  #   @options_for_services = []
  # end

  # def create
  #   @task = Task.new(task_params)
  #   @categories = Task::CATEGORIES

  #   if @task.save
  #     redirect_to task_path(@task), notice: 'Task was successfully created'
  #   else
  #     @task.category.present? ? @options_for_subcategory = Task::SUBCATEGORIES[@task.category] : @options_for_subcategory = []
  #     @task.subcategory.present? ? @options_for_services = Service::SERVICES[@task.subcategory] : @options_for_services = []
  #     @checked_services = find_checked_services(@task, @options_for_services)
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  def edit
    @task = Task.find(params[:id])
    @categories = Task::CATEGORIES
    @options_for_subcategory = Task::SUBCATEGORIES[@task.category]
    @options_for_services = Service::SERVICES[@task.subcategory]
    @checked_services = find_checked_services(@task, @options_for_services)
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      redirect_to task_path(@task), notice: 'Task was successfully updated'
    else
      @options_for_services = Service::SERVICES[@task.subcategory]
      @checked_services = find_checked_services(@task, @options_for_services)
      render :edit, status: :unprocessable_entity
    end

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
    params.require(:task).permit(:headline, :description, :category, :subcategory, :user_id, :latitude, :longitude, services_attributes: [:name, :id, :_destroy])
  end

  def find_checked_services(task, options_for_services)
    task.services.select { |service| options_for_services.include?(service.name) }
  end
end
