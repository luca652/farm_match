class ServicesController < ApplicationController
  def show
    @task = Task.find(params[:task_id])
    @service = @task.services.find(params[:id])
    @questions = @service.questions

  end
end
