class AnswersController < ApplicationController

  def new_services_answers
    @job = Job.find(params[:job_id])
    @services = @job.services
  end
end
