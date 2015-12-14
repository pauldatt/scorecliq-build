class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.string :user_id
      t.string :friend_id
      t.boolean :approved

      t.timestamps null: false
    end
    add_index :friendships, :user_id
    add_index :friendships, :friend_id
    add_index :friendships, [:user_id, :friend_id], unique: true
  end
end
