class QuestionsController < ApplicationController

  def options_for_question
    @target = params[:target]
    @answer = params[:answer]
    @options_for_question = QuestionnaireGenerator::FOLLOW_UP_OPTIONS[@answer]

    respond_to do |format|
      format.turbo_stream
    end
  end

end
