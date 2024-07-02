class RecreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :name
      t.references :task, null: false, foreign_key: true
      t.timestamps
    end
  end
end
