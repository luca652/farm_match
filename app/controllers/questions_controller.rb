class QuestionsController < ApplicationController

  def options_for_question
    @target = params[:target]
    @answer = params[:answer]
    @question_wording = params[:question_wording]
    @options_for_question = QuestionnaireGenerator::FOLLOW_UP_OPTIONS[@question_wording][@answer]

    respond_to do |format|
      format.turbo_stream
    end
  end

end
