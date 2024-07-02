class RenameJobsToTasks < ActiveRecord::Migration[7.0]
  def change
    rename_table :jobs, :tasks
  end
end
