class FixColumnName < ActiveRecord::Migration
  def self.up
  	rename_column :promos, :file_name, :url
  end

  def self.down
  	rename_column :promos, :url, :file_name
  end
end
