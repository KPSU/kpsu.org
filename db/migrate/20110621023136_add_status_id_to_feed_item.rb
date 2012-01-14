class AddStatusIdToFeedItem < ActiveRecord::Migration
  def self.up
    add_column :feed_items, :status_id, :integer
  end

  def self.down
    remove_column :feed_items, :status_id
  end
end
