class CreatePlaylistItems < ActiveRecord::Migration
  def self.up
    create_table :playlist_items do |t|
      t.integer :playlist_id
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :playlist_items
  end
end
