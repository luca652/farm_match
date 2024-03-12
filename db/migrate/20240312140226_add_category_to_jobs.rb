class AddCategoryToJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :category, :string
  end
end
