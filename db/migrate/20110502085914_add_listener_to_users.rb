class AddListenerToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :listener, :boolean
  end

  def self.down
    remove_column :users, :listener
  end
end
