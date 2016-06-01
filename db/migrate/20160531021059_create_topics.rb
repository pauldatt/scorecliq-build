class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :subject
      t.integer :user_id
      t.references :scoreboard, index: true

      t.timestamps null: false
    end
    add_foreign_key :topics, :scoreboards
    add_index :topics, :user_id
  end
  
end
