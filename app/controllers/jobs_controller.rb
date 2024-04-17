class JobsController < ApplicationController

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
    @categories = Job::CATEGORIES
    @service_options = Service::SERVICES['Application (Spraying and Spreading)']
    @job.services.build
  end

  def create
    @job = Job.new(job_params)
    @categories = Job::CATEGORIES
    @service_options = Service::SERVICES['Application (Spraying and Spreading)']

    if @job.save
      redirect_to job_path(@job), notice: 'Job was successfully created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def subcategories
    @target = params[:target]
    @category = params[:category]
    @subcategories = Job::SUBCATEGORIES[@category]

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def job_params
    params.require(:job).permit(:headline, :description, :category, :subcategory, :user_id,
                                services_attributes: [:name])
  end
end
