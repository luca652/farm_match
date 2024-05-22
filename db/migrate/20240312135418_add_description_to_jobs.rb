class AddDescriptionToJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :description, :string
  end
end
