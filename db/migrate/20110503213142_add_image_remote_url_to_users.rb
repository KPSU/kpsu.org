class AddImageRemoteUrlToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :image_remote_url, :string
  end

  def self.down
    remove_column :users, :image_remote_url
  end
end
