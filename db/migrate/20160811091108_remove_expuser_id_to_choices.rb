class RemoveExpuserIdToChoices < ActiveRecord::Migration[5.0]
  def change
    remove_column :choices, :expuser_id, :integer
  end
end
