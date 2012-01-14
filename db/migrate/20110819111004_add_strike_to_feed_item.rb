class AddStrikeToFeedItem < ActiveRecord::Migration
  def self.up
    add_column :feed_items, :strike_id, :integer
  end

  def self.down
    remove_column :feed_items, :strike_id
  end
end
