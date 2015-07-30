class AddCountryToScoreboards < ActiveRecord::Migration
  def change
    add_column :scoreboards, :country, :string
  end
end
