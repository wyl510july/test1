class CreateExpusers < ActiveRecord::Migration[5.0]
  def change
    create_table :expusers do |t|
        t.integer  :experiment_id
        t.integer  :user_id

      t.timestamps
    end
  end
end
