class RemoveDownloadFromPlaylists < ActiveRecord::Migration
  def self.up
  	remove_column :playlists, :download_id
  end

  def self.down
    add_column :playlists, :download_id, :integer
  end
end
