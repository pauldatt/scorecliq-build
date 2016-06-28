class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.string :subject

      t.timestamps null: false
    end
  end
end
