class ServicesController < ApplicationController

  def new
    @job = Job.find(params[:job_id])
    @services_options = Service::SERVICES[@job.subcategory]
  end

  def create
    @job = Job.find(params[:job_id])
    @services = params[:services]
    @services.each do |service|
      @service = Service.new(name: service, job_id: @job.id)
      if @service.save
      else
        render :new, status: :unprocessable_entity
      end
    end
  end
end
