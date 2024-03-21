class JobsController < ApplicationController

  def new
    @job = Job.new
    @categories = Job::CATEGORIES
    @subcategories = Job::SUBCATEGORIES[@job.category]
  end

  def create
    @job = Job.new(job_params)

    if @job.save
      redirect_to job_path(@job)
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
    params.require(:job).permit(:headline, :description, :category, :subcategory, :user_id)
  end
end
