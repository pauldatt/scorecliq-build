class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :recipient_name
      t.string :recipient_email
      t.references :scoreboard, index: true #the reference adds a scoreboard_id column with an index and a foreign key reference

      t.timestamps null: false
    end
    add_foreign_key :invitations, :scoreboards
  end
end

