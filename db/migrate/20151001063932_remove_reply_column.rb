class RemoveReplyColumn < ActiveRecord::Migration
   def self.up
    remove_column :comments, :reply
   end
end
