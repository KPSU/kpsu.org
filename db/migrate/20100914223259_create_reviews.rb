class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.string :title
      t.string :type
      t.integer :genre_id
      t.string :artist
      t.string :album
      t.string :venue
      t.string :record_label
      t.text :review
      t.string :artist_homepage
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :reviews
  end
end
