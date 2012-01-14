class AddPositionToTrack < ActiveRecord::Migration
  def self.up
    add_column :tracks, :position, :integer
  end

  def self.down
    remove_column :tracks, :position
  end
end
