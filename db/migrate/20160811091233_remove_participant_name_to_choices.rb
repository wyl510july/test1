class RemoveParticipantNameToChoices < ActiveRecord::Migration[5.0]
  def change
    remove_column :choices, :participant_name, :string
  end
end
