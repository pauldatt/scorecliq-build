class AddLocationToScoreboards < ActiveRecord::Migration
  def change
    add_column :scoreboards, :location, :string
  end
end
