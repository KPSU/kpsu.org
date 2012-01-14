class AddPhoneToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :phone, :integer
  end

  def self.down
    remove_column :users, :phone
  end
end
