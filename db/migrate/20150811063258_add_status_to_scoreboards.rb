class AddStatusToScoreboards < ActiveRecord::Migration
  def change
    add_column :scoreboards, :status, :string
  end
end
