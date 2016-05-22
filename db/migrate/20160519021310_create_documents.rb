class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :file_name
      t.string :file
      t.references :category, index: true

      t.timestamps null: false
    end
    add_foreign_key :documents, :categories
  end
end
