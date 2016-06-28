class CreateUserConversations < ActiveRecord::Migration
  def change
    create_table :user_conversations do |t|
      t.integer :user_id
      t.integer :conversation_id
      t.boolean :deleted
      t.boolean :read

      t.timestamps null: false
    end
    add_index :user_conversations, :user_id
    add_index :user_conversations, :conversation_id
  end
end
