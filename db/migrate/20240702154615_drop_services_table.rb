class DropServicesTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :services
  end
end
