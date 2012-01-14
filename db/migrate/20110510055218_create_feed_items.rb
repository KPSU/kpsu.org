class CreateFeedItems < ActiveRecord::Migration
  def self.up
    create_table :feed_items do |t|
      t.integer :feed_id
      t.integer :comment_id
      t.string :content_type

      t.timestamps
    end
  end

  def self.down
    drop_table :feed_items
  end
end
