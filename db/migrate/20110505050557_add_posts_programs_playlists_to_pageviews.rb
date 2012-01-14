class AddPostsProgramsPlaylistsToPageviews < ActiveRecord::Migration
  def self.up
    add_column :pageviews, :post_id, :integer
    add_column :pageviews, :program_id, :integer
    add_column :pageviews, :playlist_id, :integer
  end

  def self.down
    remove_column :pageviews, :playlist_id
    remove_column :pageviews, :program_id
    remove_column :pageviews, :post_id
  end
end
