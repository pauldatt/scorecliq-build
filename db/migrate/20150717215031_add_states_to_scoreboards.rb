class AddStatesToScoreboards < ActiveRecord::Migration
  def change
    add_column :scoreboards, :states, :string
  end
end
