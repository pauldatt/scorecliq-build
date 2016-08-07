class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.integer :user_id
      t.integer :amount
      t.string :card_last4
      t.string :stripe_charge_id
      t.boolean :success

      t.timestamps null: false
    end
    
    add_index :charges, :stripe_charge_id, unique: true
  end
end
