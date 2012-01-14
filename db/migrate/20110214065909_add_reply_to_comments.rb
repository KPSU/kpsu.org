class AddReplyToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :reply_id, :integer
  end

  def self.down
    remove_column :comments, :reply_id
  end
end
