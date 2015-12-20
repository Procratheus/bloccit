class RenameAdvertismentsToAdevertisements < ActiveRecord::Migration
  def change
    rename_table :advertisments, :advertisements
  end
end
