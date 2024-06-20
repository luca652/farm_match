class ServicesController < ApplicationController

  def new
    @job = Job.find(params[:job_id])
    @services_options = Service::SERVICES[@job.subcategory]
  end

  def create
    @job = Job.find(params[:job_id])
    @params = services_params

    Service.transaction do
      @services = Service.create!(services_params)
    end
  end

  private

  def services_params
    params.permit(:commit, :job_id, :authenticity_token, services: [:name]).require(:services)
  end
end
