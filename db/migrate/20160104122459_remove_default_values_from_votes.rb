class RemoveDefaultValuesFromVotes < ActiveRecord::Migration
  def change
    change_column :votes, :value, :integer, default: nil
  end
end
