class CreateDownloads < ActiveRecord::Migration
  def self.up
    create_table :downloads do |t|
      t.string :title
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :count
      t.integer :program_id
      t.integer :playlist_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :downloads
  end
end
