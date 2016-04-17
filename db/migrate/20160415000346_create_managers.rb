class CreateManagers < ActiveRecord::Migration
  def change
    create_table :managers do |t|
      t.integer :user_id
      t.integer :scoreboard_id

      t.timestamps null: false
    end
    add_index :managers, :user_id
    add_index :managers, :scoreboard_id
  end
end
