class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :team1
      t.string :team2
      t.text :detail
      t.references :scoreboard, index: true

      t.timestamps null: false
    end
    add_foreign_key :schedules, :scoreboards
  end
end
