class RemoveColumn < ActiveRecord::Migration
  def self.up
    remove_column :teams, :win_percentage
  end
end
