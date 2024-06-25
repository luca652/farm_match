class ServicesController < ApplicationController

  def new
    @job = Job.find(params[:job_id])
    @services_options = Service::SERVICES[@job.subcategory]
  end

  def create
    @job = Job.find(params[:job_id])
    @services_options = Service::SERVICES[@job.subcategory]

    full_params = services_params.map { |service_param| service_param.merge(job_id: @job.id) }

    begin
      Service.transaction do
        @services = Service.create!(full_params)
      end

      redirect_to new_answers_job_services_path

    rescue ActiveRecord::RecordInvalid => exception
      @errors = exception.record.errors
      render :new, status: :unprocessable_entity
    end

  end

  private

  def services_params
    params.permit(:commit, :job_id, :authenticity_token, services: [:name]).require(:services)
  end
end
