class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.text :content
      t.references :scoreboard, index: true

      t.timestamps null: false
    end
    change_column :statuses, :content, :text, :default => "upload status"
    add_foreign_key :statuses, :scoreboards
  end
end