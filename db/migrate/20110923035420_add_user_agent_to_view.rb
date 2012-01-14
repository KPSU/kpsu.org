class AddUserAgentToView < ActiveRecord::Migration
  def self.up
    add_column :views, :user_agent, :string
  end

  def self.down
    remove_column :views, :user_agent
  end
end
