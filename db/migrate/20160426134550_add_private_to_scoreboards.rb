class AddPrivateToScoreboards < ActiveRecord::Migration
  def change
    add_column :scoreboards, :privatization, :boolean, default: false
  end
end
