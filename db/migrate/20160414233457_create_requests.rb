class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :user_id
      t.integer :scoreboard_id
      t.boolean :approved

      t.timestamps null: false
    end
    add_index :requests, :user_id
    add_index :requests, :scoreboard_id
  end
end
