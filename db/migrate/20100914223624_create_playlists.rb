class CreatePlaylists < ActiveRecord::Migration
  def self.up
    create_table :playlists do |t|
      t.integer :program_id
      t.string :title
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :playlists
  end
end
