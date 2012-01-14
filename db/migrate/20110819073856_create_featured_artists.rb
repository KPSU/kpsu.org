class CreateFeaturedArtists < ActiveRecord::Migration
  def self.up
    create_table :featured_artists do |t|
      t.integer :artist_id

      t.timestamps
    end
  end

  def self.down
    drop_table :featured_artists
  end
end
