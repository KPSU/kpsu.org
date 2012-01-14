class CreateTmpPlaylistTracks < ActiveRecord::Migration
  def self.up
    create_table :tmp_playlist_tracks do |t|
      t.string :title
      t.integer :nid
      t.integer :weight
      t.string :artist
      t.string :album
      t.string :label

      t.timestamps
    end
  end

  def self.down
    drop_table :tmp_playlist_tracks
  end
end
