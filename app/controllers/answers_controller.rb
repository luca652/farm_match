class AnswersController < ApplicationController

  def new_services_answers
    @job = Job.find(params[:job_id])
    @services = @job.services
  end

  def create_services_answers
    @job = Job.find(params[:job_id])

    @answers = []
    params[:answers].each do |index, answer|
      @answers << Answer.new(service_id: answer[:service_id],
                    label: answer[:label],
                    details: answer[:details])
    end

    if @answers.all?(&:save!)
      redirect_to job_path(@job)
    else
      @services = @job.services
      render :new_services_answers, status: :unprocessable_entity
    end
  end
end
