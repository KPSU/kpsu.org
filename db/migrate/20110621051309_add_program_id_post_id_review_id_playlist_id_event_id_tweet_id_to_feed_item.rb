class AddProgramIdPostIdReviewIdPlaylistIdEventIdTweetIdToFeedItem < ActiveRecord::Migration
  def self.up
    add_column :feed_items, :program_id, :integer
    add_column :feed_items, :post_id, :integer
    add_column :feed_items, :review_id, :integer
    add_column :feed_items, :playlist_id, :integer
    add_column :feed_items, :event_id, :integer
    add_column :feed_items, :tweet_id, :integer
  end

  def self.down
    remove_column :feed_items, :tweet_id
    remove_column :feed_items, :event_id
    remove_column :feed_items, :playlist_id
    remove_column :feed_items, :review_id
    remove_column :feed_items, :post_id
    remove_column :feed_items, :program_id
  end
end
