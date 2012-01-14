class CreateArtistPlaylists < ActiveRecord::Migration
  def self.up
    create_table :artist_playlists do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :artist_playlists
  end
end
