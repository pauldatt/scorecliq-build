class AddEndsAtToScoreboards < ActiveRecord::Migration
  def change
    add_column :scoreboards, :ends_at, :date
  end
end
