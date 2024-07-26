class TasksController < ApplicationController

  def show
    @task = Task.find(params[:id])
  end

  def new_step_one
    session[:task_params] ? @task = Task.new(session[:task_params]) : @task = Task.new
    @task.current_step = 'step_one'
    set_categories_and_subcategories
  end

  def create_step_one
    @task = Task.new(task_params)
    @task.current_step = 'step_one'
    if @task.valid?
      session[:task_params] = task_params
      redirect_to new_step_two_tasks_path
    else
      set_categories_and_subcategories
      render :new_step_one, status: :unprocessable_entity
    end
  end

  def new_step_two
    unless session[:task_params]
      redirect_to new_step_one_tasks_path, alert: 'Please start from the beginning'
      return
    end

    @task = Task.new(session[:task_params])
    @task.current_step = 'step_two'
    @options_for_services = Service::SERVICES[@task.subcategory]
  end

  def create
    @task = Task.new(session[:task_params])
    @task.current_step = 'step_two'
    @task.assign_attributes(task_params)
    if @task.save
      session.delete(:task_params)
      redirect_to task_path(@task), notice: 'Task was successfully created'
    else
      @options_for_services = Service::SERVICES[@task.subcategory]
      flash.now[:alert] = 'There was an error creating the task.'
      render :new_step_two, status: :unprocessable_entity
    end
  end

  def edit_step_one
    @task = Task.find(params[:id])
    @categories = Task::CATEGORIES
    @options_for_subcategory = Task::SUBCATEGORIES[@task.category]
  end

  def update_step_one
      @task = Task.find(params[:id])
    if @task.update(task_params)
      session[:task_params] = @task.attributes
      redirect_to edit_step_two_task_path(@task)
    else
      render :edit_step_one, status: :unprocessable_entity
    end
  end

  def edit_step_two
    @task = Task.find(params[:id])
    @options_for_services = Service::SERVICES[@task.subcategory]
    @checked_services = @task.services
  end

  def update
    @task = Task.find(params[:id])

    remove_invalid_services(@task)

    if @task.update(task_params)
      redirect_to task_path(@task), notice: 'Task was successfully updated'
    else
      @options_for_services = Service::SERVICES[@task.subcategory]
      @checked_services = @task.services
      render :edit_step_two, status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    # redirect_to tasks_path
  end

  def options_for_subcategory
    @target = params[:target]
    @category = params[:category]
    @options_for_subcategory = Task::SUBCATEGORIES[@category]

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def task_params
    params.fetch(:task, {}).permit(:headline, :description, :category, :subcategory, :user_id, :latitude, :longitude, services_attributes: [:id, :name, :_destroy])
  end

  def remove_invalid_services(task)
    valid_services = Service::SERVICES[task.subcategory]
    task.services.each do |service|
      service.mark_for_destruction unless valid_services.include?(service.name)
    end
  end

  def set_categories_and_subcategories
    @categories = Task::CATEGORIES
    @options_for_subcategory = if @task.category.present?
      Task::SUBCATEGORIES[@task.category] || []
    else
      []
    end
  end
end
