class AddCatalogToAlbum < ActiveRecord::Migration
  def self.up
    add_column :albums, :catalog, :boolean
  end

  def self.down
    remove_column :albums, :catalog
  end
end
