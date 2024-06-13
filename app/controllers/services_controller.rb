class ServicesController < ApplicationController

  def new
    @job = Job.find(params[:job_id])
    @services_options = Service::SERVICES[@job.subcategory]
  end

  def create
    @job = Job.find(params[:job_id])
    @service_names = service_params || []

    @services = @service_names.map do |service|
      @job.services.build(name: service[:name])
    end

    if @services.all?(&:save)
      redirect_to new_services_answers_job_services_path(@job), notice: 'Services were added to your job.'
    else
      flash.now[:alert] = "You must select at least one service."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def service_params
    params.require(:services).map { |s| s.permit(:name) }
  end
end
