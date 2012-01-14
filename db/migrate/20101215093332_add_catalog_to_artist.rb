class AddCatalogToArtist < ActiveRecord::Migration
  def self.up
    add_column :artists, :catalog, :boolean
  end

  def self.down
    remove_column :artists, :catalog
  end
end
