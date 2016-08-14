class RemoveStateToUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :state, :integer
  end
end
