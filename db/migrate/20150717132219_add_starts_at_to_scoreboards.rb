class AddStartsAtToScoreboards < ActiveRecord::Migration
  def change
    add_column :scoreboards, :starts_at, :date
  end
end
