class AddExperimentIdToChoices < ActiveRecord::Migration[5.0]
  def change
    add_column :choices, :experiment_id, :integer
  end
end
