class AddRecipientToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :recipient, :integer
  end

  def self.down
    remove_column :comments, :recipient
  end
end
