class ServicesController < ApplicationController

  def new
    @task = Task.find(params[:task_id])
    @services_options = Service::SERVICES[@task.subcategory]
  end

  def create
    @task = Task.find(params[:task_id])
    @services_options = Service::SERVICES[@task.subcategory]

    @services_params = services_params
    full_params = @services_params.map { |service_param| service_param.merge(task_id: @task.id) }

    begin
      Service.transaction do
        @services = Service.create!(full_params)
      end

      redirect_to new_answers_task_services_path

    rescue ActiveRecord::RecordInvalid => exception
      @errors = exception.record.errors
      render :new, status: :unprocessable_entity
    end

  end

  private

  def services_params
    params.require(:services).map { |param| param.permit(:name) }
  end
end
