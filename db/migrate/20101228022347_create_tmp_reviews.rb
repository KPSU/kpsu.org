class CreateTmpReviews < ActiveRecord::Migration
  def self.up
    create_table :tmp_reviews do |t|
      t.integer :uid
      t.string :name
      t.string :email
      t.integer :nid
      t.integer :field_rating_value
      t.text :field_review_value
      t.string :field_artist_value
      t.string :field_album_value
      t.string :field_record_label

      t.timestamps
    end
  end

  def self.down
    drop_table :tmp_reviews
  end
end
