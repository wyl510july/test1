class AddParticipantIdToChoices < ActiveRecord::Migration[5.0]
  def change
    add_column :choices, :participant_id, :integer
  end
end
