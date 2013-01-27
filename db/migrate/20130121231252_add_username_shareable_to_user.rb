class AddUsernameShareableToUser < ActiveRecord::Migration
  def change
    add_column :users, :user_name, :string
    add_column :users, :shareable, :boolean
  end
end
