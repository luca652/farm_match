class AddHeadlineToJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :headline, :string
  end
end
