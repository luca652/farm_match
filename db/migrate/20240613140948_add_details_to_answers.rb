class AddDetailsToAnswers < ActiveRecord::Migration[7.0]
  def change
    add_column :answers, :details, :jsonb, default: {}
  end
end
