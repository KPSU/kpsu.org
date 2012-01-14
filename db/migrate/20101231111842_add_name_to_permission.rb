class AddNameToPermission < ActiveRecord::Migration
  def self.up
    add_column :permissions, :name, :string
  end

  def self.down
    remove_column :permissions, :name
  end
end
