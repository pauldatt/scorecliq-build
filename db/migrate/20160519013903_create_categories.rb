class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.references :scoreboard, index: true

      t.timestamps null: false
    end
    add_foreign_key :categories, :scoreboards
  end
end
