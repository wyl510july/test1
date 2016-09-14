class CreateChoices < ActiveRecord::Migration[5.0]
  def change
    create_table :choices do |t|
        t.integer  :experiment_id
        t.integer  :user_id
        t.integer  :participant_id
        t.integer  :preference
        t.string  :submitted

      t.timestamps
    end
  end
end
