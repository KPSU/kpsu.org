class AddProfileIdToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :profile_id, :integer
  end

  def self.down
    remove_column :comments, :profile_id
  end
end
