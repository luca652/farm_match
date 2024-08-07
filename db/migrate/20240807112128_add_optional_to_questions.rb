class AddOptionalToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :optional, :boolean, default: false
  end
end
