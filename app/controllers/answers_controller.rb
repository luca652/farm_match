class AnswersController < ApplicationController

  def new_answers
    @task = Task.find(params[:task_id])
    @services = @task.services
  end

  def create_answers
    @task = Task.find(params[:task_id])


    # @answers = []
    # answers_params.each do |index, answer|
    #   @answers << Answer.new(answer_params(answer))
    # end


    begin
      Answer.transaction do
        @answers = Service.create!(answers_params)
      end

      redirect_to task_path(@task)

    rescue ActiveRecord::RecordInvalid => exception
      @errors = exception.record.errors
      render :new_answers, status: :unprocessable_entity
    end

  end

  private

  def answers_params
    params.require(:answers).permit(

      [
        # This allows any number of nested hashes within 'answers'
        # treating it as an array of hashes
        :kind,
        :service_id,
        :label,
        [ details: [:answer, :unit, :value, :description] ]
      ]

  )
  end
end
