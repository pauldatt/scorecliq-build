class AddCitiesToScoreboards < ActiveRecord::Migration
  def change
    add_column :scoreboards, :cities, :string
  end
end
