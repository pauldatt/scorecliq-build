class AddPrivateToScoreboards < ActiveRecord::Migration
  def change
    add_column :scoreboards, :private, :boolean, default: false
  end
end
