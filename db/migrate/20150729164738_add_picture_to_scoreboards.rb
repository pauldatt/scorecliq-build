class AddPictureToScoreboards < ActiveRecord::Migration
  def change
    add_column :scoreboards, :picture, :string
  end
end
