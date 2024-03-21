class AddJobRefToServices < ActiveRecord::Migration[7.0]
  def change
    add_reference :services, :job, null: false, foreign_key: true
  end
end
