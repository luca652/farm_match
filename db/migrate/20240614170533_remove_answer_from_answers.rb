class RemoveAnswerFromAnswers < ActiveRecord::Migration[7.0]
  def change
    remove_column :answers, :answer, :string
  end
end
