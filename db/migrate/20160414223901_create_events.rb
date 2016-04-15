class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :event_name
      t.date :event_date
      t.time :event_time
      t.string :notes
      t.references :scoreboard, index: true

      t.timestamps null: false
    end
    add_foreign_key :events, :scoreboards
  end
end
