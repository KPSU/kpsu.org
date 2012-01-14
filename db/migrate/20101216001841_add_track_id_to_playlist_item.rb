class AddTrackIdToPlaylistItem < ActiveRecord::Migration
  def self.up
    add_column :playlist_items, :track_id, :integer
  end

  def self.down
    remove_column :playlist_items, :track_id
  end
end
