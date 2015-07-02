class CreateScoreboards < ActiveRecord::Migration
  def change
    create_table :scoreboards do |t|
      t.string :name_of_scoreboard
      t.string :name_of_organization
      t.string :name_of_activity
      t.text :content # admin message area
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :scoreboards, :users
    add_index :scoreboards, [:user_id, :created_at]
  end
end
