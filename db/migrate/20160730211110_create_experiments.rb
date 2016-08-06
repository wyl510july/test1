class CreateExperiments < ActiveRecord::Migration[5.0]
  def change
    create_table :experiments do |t|
        t.string :min
        t.string :max
        t.text :description

      t.timestamps
    end
  end
end
