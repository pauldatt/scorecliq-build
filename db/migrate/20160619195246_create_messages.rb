class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :user, index: true
      t.references :conversation, index: true
      t.text :body

      t.timestamps null: false
    end
    add_foreign_key :messages, :users
    add_foreign_key :messages, :conversations
  end
end
