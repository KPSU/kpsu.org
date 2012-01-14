class AddFileSizeToDownloads < ActiveRecord::Migration
  def self.up
    add_column :downloads, :file_size, :integer
  end

  def self.down
    remove_column :downloads, :file_size
  end
end
