class AddNd < ActiveRecord::Migration
  def self.up
    add_column :users, :nid, :integer
    add_column :posts, :nid, :integer
    add_column :catalogs, :nid, :integer
    add_column :programs, :nid, :integer
    add_column :playlists, :nid, :integer
    add_column :playlist_items, :nid, :integer
  end

  def self.down
    remove_column :users, :nid
    remove_column :posts, :nid
    remove_column :catalog, :nid
    remove_column :programs, :nid
    remove_column :playlists, :nid
    remove_column :playlist_items, :nid
  end
end
