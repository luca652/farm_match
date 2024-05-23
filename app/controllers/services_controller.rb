class ServicesController < ApplicationController

  def new
    @job = Job.find(params[:job_id])
    @services_options = Service::SERVICES[@job.subcategory]
  end

  def create
    @job = Job.find(params[:job_id])
    @service_names = service_params[:services] || []

    @services = @service_names.map do |service|
      @job.services.build(name: service[:name])
    end

    if @services.all?(&:save)
      redirect_to job_path(@job), notice: 'Services were added to your job.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def service_params
    params.require(:services)
    params.permit(:job_id, services: [:name])
  end
end
