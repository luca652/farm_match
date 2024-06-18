class AddKindToAnswers < ActiveRecord::Migration[7.0]
  def change
    add_column :answers, :kind, :integer
  end
end
