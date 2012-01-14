class AddMoreIndexes < ActiveRecord::Migration
  def self.up
    add_index :feed_items, :id
    add_index :playlist_items, :id
    add_index :downloads, :id
    add_index :playlists, :id
    add_index :albums, :id
    add_index :programs, :id
    add_index :posts, :id
    add_index :tracks, :id
    add_index :views, :id
    add_index :events, :id
    add_index :user_groups, :id
  end

  def self.down
  end
end
