class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :win
      t.integer :loss
      t.integer :tie
      t.references :scoreboard, index: true

      t.timestamps null: false
    end
    add_foreign_key :teams, :scoreboards
  end
end
