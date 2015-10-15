class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites do |t|
      t.integer :user_id
      t.integer :scoreboard_id

      t.timestamps null: false
    end
    add_index :favourites, :user_id
    add_index :favourites, :scoreboard_id
    add_index :favourites, [:user_id, :scoreboard_id], unique: true
  end
end
