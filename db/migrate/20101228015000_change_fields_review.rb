class ChangeFieldsReview < ActiveRecord::Migration
  def self.up
    rename_column :reviews, :artist, :artist_id
    rename_column :reviews, :album, :album_id
    rename_column :reviews, :record_label, :label_id
    rename_column :reviews, :type, :content_type
    rename_column :reviews, :review, :body
    rename_column :reviews, :artist_homepage, :link
  end

  def self.down
  end
end
