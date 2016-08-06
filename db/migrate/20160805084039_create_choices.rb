class CreateChoices < ActiveRecord::Migration[5.0]
  def change
    create_table :choices do |t|
        t.integer  :expuser_id
        t.string  :participant_name
        t.integer  :preference
        t.string  :submitted

      t.timestamps
    end
  end
end
