class AddTNumberToTrack < ActiveRecord::Migration
  def self.up
    add_column :tracks, :t_number, :integer
  end

  def self.down
    remove_column :tracks, :t_number
  end
end
