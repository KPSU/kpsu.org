class AddUrlToDownload < ActiveRecord::Migration
  def self.up
    add_column :downloads, :url, :string
  end

  def self.down
    remove_column :downloads, :url
  end
end
