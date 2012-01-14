class FixRecipient < ActiveRecord::Migration
  def self.up
    rename_column :comments, :recipient, :recipient_id
  end

  def self.down
  end
end