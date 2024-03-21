class AddNameToServices < ActiveRecord::Migration[7.0]
  def change
    add_column :services, :name, :string
  end
end
