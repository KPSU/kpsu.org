class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.integer :program_id
      t.integer :interview_id
      t.integer :review_id
      t.integer :post_id
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.text :exif

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
