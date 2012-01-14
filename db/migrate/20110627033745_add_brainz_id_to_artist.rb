class AddBrainzIdToArtist < ActiveRecord::Migration
  def self.up
    add_column :artists, :brainz_id, :string
  end

  def self.down
    remove_column :artists, :brainz_id
  end
end
