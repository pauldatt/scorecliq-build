class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.integer :team_id
      t.integer :user_id
      t.boolean :captain

      t.timestamps null: false
    end
    add_index :team_members, :team_id
    add_index :team_members, :user_id
  end
end
