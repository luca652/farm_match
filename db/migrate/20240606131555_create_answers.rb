class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.string :label
      t.string :answer
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
