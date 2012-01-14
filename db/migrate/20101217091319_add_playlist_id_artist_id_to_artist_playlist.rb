class AddPlaylistIdArtistIdToArtistPlaylist < ActiveRecord::Migration
  def self.up
    add_column :artist_playlists, :playlist_id, :integer
    add_column :artist_playlists, :artist_id, :integer
  end

  def self.down
    remove_column :artist_playlists, :artist_id
    remove_column :artist_playlists, :playlist_id
  end
end
