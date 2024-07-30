class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.references :service, null: false, foreign_key: true
      t.string :answer_title
      t.json :answer, default: {}
      t.integer :kind
      t.string :wording
      t.string :options, array: true, default: []
      t.timestamps
    end
  end
end
