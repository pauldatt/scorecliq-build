class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :picture
      t.integer :pictureable_id 
      t.string :pictureable_type #name of the class is stored in picturable_type column

      t.timestamps null: false
    end
    add_index :pictures, [:pictureable_id, :pictureable_type]
  end
end
