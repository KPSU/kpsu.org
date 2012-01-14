class AddYearToAlbum < ActiveRecord::Migration
  def self.up
    add_column :albums, :year, :datetime
  end

  def self.down
    remove_column :albums, :year
  end
end
