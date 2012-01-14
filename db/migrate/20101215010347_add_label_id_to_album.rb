class AddLabelIdToAlbum < ActiveRecord::Migration
  def self.up
    add_column :albums, :label_id, :integer
  end

  def self.down
    remove_column :albums, :label_id
  end
end
