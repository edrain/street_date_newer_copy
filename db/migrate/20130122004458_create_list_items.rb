class CreateListItems < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.integer :user_id, :null => false
      t.integer :artist_id, :null => false

      t.timestamps
    end
  end
end
