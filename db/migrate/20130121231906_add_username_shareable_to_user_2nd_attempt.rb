class AddUsernameShareableToUser2ndAttempt < ActiveRecord::Migration
  def change
    remove_column :users, :user_name
    remove_column :users, :shareable
    add_column :users, :user_name, :string
    add_column :users, :shareable, :boolean, :null => false, :default => 0
    change_column :users, :user_name, :string, :null => false
  end
end
