class JobsController < ApplicationController

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
    @categories = Job::CATEGORIES
  end

  def create
    @job = Job.new(job_params)
    @categories = Job::CATEGORIES

    if @job.save
      redirect_to new_job_service_path(@job), notice: 'Job was successfully created'
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
    params.require(:job).permit(:headline, :description, :category, :subcategory, :user_id, :latitude, :longitude)
  end
end
