class AddDetailstoSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :match_date, :date
    add_column :schedules, :match_time, :string
  end
end
