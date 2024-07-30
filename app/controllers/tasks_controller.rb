class TasksController < ApplicationController
  # This controller manages a multi-step task creation process:
  # Step 1: Basic task information (headline, location, category, subcategory)
  # Step 2: Service selection
  # Step 3: Additional details and task creation

  before_action :set_task, only: [:show, :edit_step_one, :update_step_one, :edit_step_two, :update_step_two, :edit_step_three, :update, :destroy]
  before_action :ensure_task_params, only: [:new_step_two, :create_step_two, :new_step_three, :create]

  def show
  end

  # Step 1: Collect basic task information
  def new_step_one
    build_task_from_session
    @task.current_step = 'step_one'
    set_categories_and_subcategories
  end

  # Submission of step 1: the params are stored in the session
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

  # Step 2: Select services for the task. List of services is based on task's subcategory.
  def new_step_two
    build_task_from_session
    @task.current_step = 'step_two'
    set_options_for_services
  end

  # Step 2 submission: the params are merged to step 1's params and saved in the session.
  def create_step_two
    merged_params = session[:task_params].deep_merge(task_params)
    @task = Task.new(merged_params)
    @task.current_step = 'step_two'

    if @task.valid?
      session[:task_params] = merged_params
      redirect_to new_step_three_tasks_path
    else
      set_options_for_services
      render :new_step_two, status: :unprocessable_entity
    end
  end

  # Step 3: user is asked to add more information to describe task. This is the last form and it triggers the create action.
  def new_step_three
    build_task_from_session
    @task.current_step = 'step_three'
  end

  # Create instance of Task and its services.
  def create
    build_task_from_session
    @task.current_step = 'step_two'
    @task.assign_attributes(task_params)
    if @task.save
      session.delete(:task_params)
      redirect_to task_path(@task), notice: 'Task was successfully created'
    else
      flash.now[:alert] = 'There was an error creating the task.'
      render :new_step_three, status: :unprocessable_entity
    end
  end

  def edit_step_one
    @categories = Task::CATEGORIES
    @options_for_subcategory = Task::SUBCATEGORIES[@task.category]
  end

  def update_step_one
    if @task.update(task_params)
      save_task_to_session
      redirect_to edit_step_two_task_path(@task)
    else
      render :edit_step_one, status: :unprocessable_entity
    end
  end

  def edit_step_two
    set_options_for_services
    @checked_services = @task.services
  end

  def update_step_two
    remove_invalid_services(@task)

    if @task.update(task_params)
      save_task_to_session
      redirect_to edit_step_three_task_path(@task)
    else
      set_options_for_services
      @checked_services = @task.services
      render :edit_step_two, status: :unprocessable_entity
    end
  end

  def edit_step_three
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task), notice: 'Task was successfully updated'
    else
      render :edit_step_three, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    # redirect_to tasks_path
  end

  # connected to 'options' stimulus controller. Sets the options for the subcategory field based on user selection of category.
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

  def set_task
    @task = Task.find(params[:id])
  end

  # sets categories and options for subcategories.
  def set_categories_and_subcategories
    @categories = Task::CATEGORIES
    @options_for_subcategory = if @task.category.present?
      Task::SUBCATEGORIES[@task.category] || []
    else
      []
    end
  end

  # Set up service options based on the task's subcategory
  def set_options_for_services
    @options_for_services = Service::SERVICES[@task.subcategory]
  end

  # Ensure we have the necessary session data to continue the multi-step process
  def ensure_task_params
    unless session[:task_params]
      redirect_to new_step_one_tasks_path, alert: missing_session_alert
    end
  end

  # Build a task object from session data
  def build_task_from_session
    @task = Task.new(session[:task_params] || {})
  end

  # Save task's attributes to the session
  def save_task_to_session
    session[:task_params] = @task.attributes
  end

  # Removes invalid services connected to the task. Useful when editing and updating.
  # When user changes subcategory, a new list of services is rendered in step 2, so the user can't uncheck previously selected services.
  def remove_invalid_services(task)
    valid_services = Service::SERVICES[task.subcategory]
    task.services.each do |service|
      service.mark_for_destruction unless valid_services.include?(service.name)
    end
  end

  def missing_session_alert
    "It seems you've skipped some steps. Please start from the beginning to ensure all necessary information is collected."
  end

end
