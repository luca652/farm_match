class AnswersController < ApplicationController

  def new_services_answers
    @job = Job.find(params[:job_id])
    @services = @job.services
  end

  def create_services_answers

    @job = Job.find(params[:job_id])

    @answers = []
    answers_params.each do |index, answer|
      @answers << Answer.new(answer_params(answer))
    end

    if @answers.all?(&:save!)
      redirect_to job_path(@job)
    else
      @services = @job.services
      render :new_services_answers, status: :unprocessable_entity
    end
  end

  private

  def answers_params
    params.require(:answers)
  end

  def answer_params(answer)
    answer.permit(:service_id, :kind, :label, details: [:answer, :unit, :value])
  end
end
