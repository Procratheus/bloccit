class AddDefaultValueToVotes < ActiveRecord::Migration
  def change
    change_column :votes, :value, :integer, default: 1
  end
end
