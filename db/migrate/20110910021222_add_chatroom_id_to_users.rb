class AddChatroomIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :chatroom_id, :string
  end

  def self.down
    remove_column :users, :chatroom_id
  end
end
