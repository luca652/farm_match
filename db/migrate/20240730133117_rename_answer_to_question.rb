class RenameAnswerToQuestion < ActiveRecord::Migration[7.0]
  def change
    rename_table :answers, :questions
  end
end
