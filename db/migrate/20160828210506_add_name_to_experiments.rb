class AddNameToExperiments < ActiveRecord::Migration[5.0]
  def change
    add_column :experiments, :name, :string
  end
end
