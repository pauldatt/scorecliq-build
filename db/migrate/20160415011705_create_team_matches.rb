class CreateTeamMatches < ActiveRecord::Migration
  def change
    create_table :team_matches do |t|
      t.integer :home_team_id
      t.integer :away_team_id
      t.date :match_date
      t.time :match_time
      t.string :location
      t.string :score

      t.timestamps null: false
    end
    add_index :team_matches, :home_team_id
    add_index :team_matches, :away_team_id
  end
end
