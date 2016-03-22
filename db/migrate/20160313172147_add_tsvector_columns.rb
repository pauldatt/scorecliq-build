class AddTsvectorColumns < ActiveRecord::Migration
  def up
    add_column :scoreboards, :tsv, :tsvector
    add_index :scoreboards, :tsv, using: "gin"

    execute <<-SQL
      CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
      ON scoreboards FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(
        tsv, 'pg_catalog.english', name_of_scoreboard, name_of_organization, name_of_activity
      );
    SQL

    now = Time.current.to_s(:db)
    update("UPDATE scoreboards SET updated_at = '#{now}'")
  end

  def down
    execute <<-SQL
      DROP TRIGGER tsvectorupdate
      ON scoreboards
    SQL

    remove_index :scoreboards, :tsv
    remove_column :scoreboards, :tsv
  end
  
end
