class AddEmailFavoritesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_favorites, :boolean, default: true
  end
end
