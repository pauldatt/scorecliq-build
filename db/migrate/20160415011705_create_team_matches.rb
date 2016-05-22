class CreateTeamMatches < ActiveRecord::Migration
  def change
    create_table :team_matches do |t|
      t.integer :team_a_id
      t.integer :team_b_id
      t.date :match_date
      t.time :match_time
      t.string :location
      t.string :score
      t.integer :scoreboard_id

      t.timestamps null: false
    end
    add_index :team_matches, :scoreboard_id
    add_index :team_matches, :team_a_id
    add_index :team_matches, :team_b_id
  end
end
