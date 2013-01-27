class AddIndexToListItem < ActiveRecord::Migration
  def change
    
    add_index :list_items, :user_id
    add_index :list_items, [ :user_id, :artist_id ], :unique => true
  end
end
